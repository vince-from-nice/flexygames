package flexygames

import grails.testing.mixin.integration.Integration
import org.jsoup.Jsoup
import spock.lang.Specification

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.nio.charset.StandardCharsets

@Integration
class PagesSpec extends Specification {

    void "the public page #path renders for a visitor"() {
        when:
        def response = get(newClient(), path)

        then:
        response.statusCode() == 200
        response.body().contains('id="mainNav"')
        response.body().contains('flexygames-modern.css')
        response.body().contains('content="width=device-width, initial-scale=1"')

        where:
        path << ['/', '/teams/list', '/sessions/list', '/player/list', '/playgrounds/list', '/site/stats', '/site/about',
                 '/auth/login']
    }

    void "a phone gets the responsive page #path, not a separate mobile page"() {
        given:
        def client = newClient()
        signIn(client, 'turman')
        String resolved = path
                .replace('{session}', "${Session.withNewTransaction { Session.list(max: 1)[0].id }}")
                .replace('{player}', "${User.withNewTransaction { User.findByUsername('turman').id }}")

        when:
        def response = get(client, resolved, IPHONE)

        then:
        response.statusCode() == 200
        response.body().contains('flexygames-modern.css')
        !response.body().contains('mobilemenu')

        where:
        path << ['/', '/sessions/show/{session}', '/player/show/{player}', '/myself/myAccount']
    }

    void "an administrator removes a role from a user through the admin form"() {
        given:
        def client = newClient()
        signIn(client, 'turman')

        when:
        Long userId = User.withNewTransaction {
            User user = User.findByUsername('user1')
            user.addToRoles(Role.findByName('Administrator'))
            user.save(flush: true, failOnError: true).id
        }

        then:
        rolesOf(userId) == ['Administrator', 'Player'] as Set

        when:
        String playerRoleId = Role.withNewTransaction { Role.findByName('Player').id as String }
        def form = Jsoup.parse(get(client, "/user/edit/${userId}").body()).selectFirst('form:has(select[name=roles])')
        def fields = form.formData().findAll { it.key() != 'roles' }.collect { [it.key(), it.value()] } + [['roles', playerRoleId]]
        def response = post(client, form.attr('action'), fields)

        then:
        response.statusCode() == 302
        rolesOf(userId) == ['Player'] as Set

        cleanup:
        User.withNewTransaction {
            User user = User.findByUsername('user1')
            user.roles.findAll { it.name != 'Player' }.each { user.removeFromRoles(it) }
            if (!user.roles*.name.contains('Player')) {
                user.addToRoles(Role.findByName('Player'))
            }
            user.save(flush: true, failOnError: true)
        }
    }

    void "a player votes for a teammate who has not received any point yet"() {
        given:
        def client = newClient()
        signIn(client, 'turman')
        Map ids = Session.withNewTransaction {
            Session session = Session.findAll { date < new Date() }.min { it.date }
            User voter = User.findByUsername('turman')
            User player = User.findByUsername('user1')
            player.votingScoreCounter = null
            player.save(flush: true, failOnError: true)
            [voter, player].each {
                new Participation(player: it, session: session, statusCode: Participation.Status.DONE_GOOD.code(),
                        lastUpdate: new Date(), lastUpdater: 'turman').save(flush: true, failOnError: true)
            }
            [session: session.id, player: player.id]
        }

        when:
        def response = post(client, '/sessions/vote', [['id', ids.session as String], ['firstChoiceBestPlayer', 'user1'], ['_action_vote', 'vote']])

        then:
        response.statusCode() == 302
        User.withNewTransaction { User.get(ids.player).votingScoreCounter } == 3

        cleanup:
        Session.withNewTransaction {
            Vote.findAllBySession(Session.get(ids.session))*.delete(flush: true)
            Participation.findAllBySession(Session.get(ids.session))*.delete(flush: true)
            User.get(ids.player).votingScoreCounter = null
        }
    }

    void "a player posts a comment on a team blog entry"() {
        given:
        def client = newClient()
        signIn(client, 'turman')
        Long entryId = BlogEntry.withNewTransaction {
            new BlogEntry(team: Team.list(max: 1)[0], user: User.findByUsername('turman'), date: new Date(),
                    title: 'Season start', body: '<p>Welcome</p>').save(flush: true, failOnError: true).id
        }
        Integer commentsBefore = User.withNewTransaction { User.findByUsername('turman').commentCounter }

        when:
        def response = post(client, '/teams/teams', [['id', entryId as String], ['comment', 'See you there'], ['_action_postBlogComment', 'Post']])

        then:
        response.statusCode() == 302
        location(response) ==~ /.*\/teams\/displayBlogEntry\/${entryId}#comment\d+/
        BlogComment.withNewTransaction { BlogComment.countByBlogEntry(BlogEntry.get(entryId)) } == 1

        cleanup:
        BlogEntry.withNewTransaction {
            BlogEntry entry = BlogEntry.get(entryId)
            BlogComment.findAllByBlogEntry(entry)*.delete(flush: true)
            entry.delete(flush: true)
            User.findByUsername('turman').commentCounter = commentsBefore
        }
    }

    void "the login and access denied pages show request values as text"() {
        when:
        def login = get(newClient(), '/auth/login?targetUri=%22%3E%3Cb%3Ex%3C%2Fb%3E&username=%3Cb%3Ey%3C%2Fb%3E')
        def denied = get(newClient(), '/auth/unauthorized?targetUri=%3Cb%3Ex%3C%2Fb%3E')

        then:
        !login.body().contains('<b>x</b>')
        !login.body().contains('<b>y</b>')
        login.body().contains('&quot;&gt;&lt;b&gt;x&lt;/b&gt;')
        !denied.body().contains('<b>x</b>')
    }

    void "a player is sent away from the admin page #path"() {
        given:
        def client = newClient()
        signIn(client, 'user1')

        when:
        def response = get(client, path)

        then:
        response.statusCode() == 302
        location(response).contains('/auth/unauthorized')

        where:
        path << ['/admin/index', '/user/index', '/role/edit/1']
    }

    void "a visitor who is not signed in is asked to sign in before posting a blog comment"() {
        given:
        def client = newClient()
        Long entryId = BlogEntry.withNewTransaction {
            new BlogEntry(team: Team.list(max: 1)[0], user: User.findByUsername('turman'), date: new Date(),
                    title: 'Season start', body: '<p>Welcome</p>').save(flush: true, failOnError: true).id
        }

        when:
        post(client, '/teams/teams', [['id', entryId as String], ['comment', 'Hello'], ['_action_postBlogComment', 'Post']])
        def page = get(client, "/teams/displayBlogEntry/${entryId}")

        then:
        page.body().contains('You need to be authenticated in order to post')
        !page.body().contains('{0}')
        BlogComment.withNewTransaction { BlogComment.countByBlogEntry(BlogEntry.get(entryId)) } == 0

        cleanup:
        BlogEntry.withNewTransaction { BlogEntry.get(entryId).delete(flush: true) }
    }

    void "a private page sends a visitor to the login page"() {
        when:
        def response = get(newClient(), '/myself/myAccount')

        then:
        response.statusCode() == 302
        location(response).contains('/auth/login')
    }

    void "a seed user signs in and opens a private page"() {
        given:
        def client = newClient()

        when:
        def signIn = signIn(client, 'turman')
        def account = get(client, '/myself/myAccount')

        then:
        signIn.statusCode() == 302
        location(signIn).endsWith('/home')
        account.statusCode() == 200
    }

    void "a missing session sends the visitor back to the session list"() {
        when:
        def response = get(newClient(), '/sessions/show/999999')

        then:
        response.statusCode() == 302
        location(response).endsWith('/sessions/list')
    }

    void "the admin list #path opens for an administrator"() {
        given:
        def client = newClient()
        signIn(client, 'turman')

        expect:
        get(client, path).statusCode() == 200

        where:
        path << ['/admin/index'] + ADMIN_CONTROLLERS.collect { "/${it}/index" }
    }

    void "a player who does not manage the team is sent back from its blog form"() {
        given:
        def client = newClient()
        signIn(client, 'user1')
        Long teamId = Team.withNewSession { Team.findByName(TEAM).id }

        when:
        def response = get(client, "/manager/editBlogEntry?teamId=${teamId}")

        then:
        response.statusCode() == 302
        location(response).endsWith("/teams/show/${teamId}")
    }

    void "a player who does not manage the team cannot remove a member"() {
        given:
        def client = newClient()
        signIn(client, 'user1')
        def (Long teamId, Long membershipId) = Membership.withNewSession {
            Team team = Team.findByName(TEAM)
            [team.id, Membership.findByUserAndTeam(User.findByUsername('user2'), team).id]
        }

        when:
        def response = get(client, "/manager/removeMembership/${membershipId}")

        then:
        response.statusCode() == 302
        location(response).endsWith("/teams/show/${teamId}")
        Membership.withNewSession { Membership.get(membershipId) } != null
    }

    void "every stylesheet, script and image of #page loads"() {
        given:
        def client = newClient()
        String path = page == 'a session page'
                ? "/sessions/show/${Session.withNewSession { Session.list(max: 1, sort: 'id').first().id }}"
                : '/'
        List<String> assets = linkedFiles(client, path)

        expect:
        assets.size() >= 5
        assets.findAll { get(client, it).statusCode() != 200 } == []

        where:
        page << ['the home page', 'a session page']
    }

    void "every file of the account page loads for a signed-in player"() {
        given:
        def client = newClient()
        signIn(client, 'turman')
        List<String> assets = linkedFiles(client, '/myself/myAccount')

        expect:
        assets.size() >= 5
        assets.findAll { get(client, it).statusCode() != 200 } == []
    }

    void "a playground without position is left off the map and its page says so"() {
        given:
        Long id = Playground.withNewTransaction { new Playground(name: 'Field without position').save(flush: true, failOnError: true).id }

        when:
        def list = get(newClient(), '/playgrounds/list')
        def page = get(newClient(), "/playgrounds/show/${id}")

        then:
        list.statusCode() == 200
        list.body().contains('Field without position')
        !(list.body() =~ /lon: *,/)
        page.statusCode() == 200
        !page.body().contains('flexyPlaygroundMap(')
        page.body().contains('No coordinates are defined for this playground')

        cleanup:
        Playground.withNewTransaction { Playground.get(id)?.delete(flush: true) }
    }

    void "the statistics page draws its rankings as bars linked to the teams, without an external chart script"() {
        when:
        def page = get(newClient(), '/site/stats')

        then:
        page.statusCode() == 200
        !page.body().contains('google.com/jsapi')
        page.body().contains('class="bar-chart"')
        page.body() =~ /class="bar-label"><a href="\/teams\/show\/\d+"/
    }

    // Local stylesheets and src attributes of the page, resolved against the page path as a browser does.
    // A browser skips the markup inside HTML comments.
    private List<String> linkedFiles(HttpClient client, String path) {
        def html = get(client, path).body().replaceAll(/(?s)<!--.*?-->/, '')
        List<String> links = (html =~ /href="([^"]+\.css)"/).collect { it[1] } + (html =~ /src="([^"]+)"/).collect { it[1] }
        links.findAll { !(it ==~ /(?i)(https?:|data:|\/\/).*/) }
                .collect { url(path).resolve(it).path }
                .unique()
    }

    void "a seed player posts a comment on a session"() {
        given:
        def client = newClient()
        signIn(client, 'user1')
        Long sessionId = Session.withNewSession { Session.list(max: 1, sort: 'id').first().id }
        Integer commentsBefore = User.withNewTransaction { User.findByUsername('user1').commentCounter }

        when:
        def response = client.send(
                HttpRequest.newBuilder(url('/sessions/post'))
                        .header('Content-Type', 'application/x-www-form-urlencoded')
                        .POST(HttpRequest.BodyPublishers.ofString("id=${sessionId}&comment=See+you+there"))
                        .build(),
                HttpResponse.BodyHandlers.ofString())

        then:
        response.statusCode() == 302
        location(response) ==~ /.*\/sessions\/show\/${sessionId}#comment\d+/

        cleanup:
        SessionComment.withNewTransaction {
            User user = User.findByUsername('user1')
            SessionComment.findAllBySessionAndUser(Session.get(sessionId), user)*.delete(flush: true)
            user.commentCounter = commentsBefore
        }
    }

    static final String TEAM = 'ASAS UrbanFoot Team'

    static final List<String> ADMIN_CONTROLLERS = ['blogComment', 'blogEntry', 'carpoolProposal', 'carpoolRequest',
            'gameAction', 'gameSkill', 'gameType', 'membership', 'participation', 'playground', 'reminder', 'role',
            'session', 'sessionComment', 'sessionGroup', 'sessionRound', 'sessionWatcher', 'subscription', 'task',
            'taskType', 'team', 'user', 'vote']

    // Seed users from BootStrap share the same password.
    private HttpResponse<String> signIn(HttpClient client, String username) {
        client.send(
                HttpRequest.newBuilder(url('/auth/signIn'))
                        .header('Content-Type', 'application/x-www-form-urlencoded')
                        .POST(HttpRequest.BodyPublishers.ofString("username=${username}&password=gluar"))
                        .build(),
                HttpResponse.BodyHandlers.ofString())
    }

    private static String location(HttpResponse<String> response) {
        response.headers().firstValue('Location').orElse('')
    }

    private static HttpClient newClient() {
        HttpClient.newBuilder()
                .cookieHandler(new CookieManager())
                .followRedirects(HttpClient.Redirect.NEVER)
                .build()
    }

    private HttpResponse<String> get(HttpClient client, String path) {
        client.send(HttpRequest.newBuilder(url(path)).build(), HttpResponse.BodyHandlers.ofString())
    }

    private static Set<String> rolesOf(Long userId) {
        User.withNewTransaction { User.get(userId).roles*.name as Set }
    }

    private HttpResponse<String> post(HttpClient client, String path, List<List<String>> fields) {
        String body = fields.collect { URLEncoder.encode(it[0], StandardCharsets.UTF_8) + '=' + URLEncoder.encode(it[1], StandardCharsets.UTF_8) }.join('&')
        client.send(
                HttpRequest.newBuilder(url(path))
                        .header('Content-Type', 'application/x-www-form-urlencoded')
                        .POST(HttpRequest.BodyPublishers.ofString(body))
                        .build(),
                HttpResponse.BodyHandlers.ofString())
    }

    private static final String IPHONE =
            'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148'

    private HttpResponse<String> get(HttpClient client, String path, String userAgent) {
        client.send(HttpRequest.newBuilder(url(path)).header('User-Agent', userAgent).build(), HttpResponse.BodyHandlers.ofString())
    }

    private URI url(String path) {
        URI.create("http://localhost:${serverPort}${path}")
    }
}
