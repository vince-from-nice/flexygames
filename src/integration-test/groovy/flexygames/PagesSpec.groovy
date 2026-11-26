package flexygames

import grails.testing.mixin.integration.Integration
import spock.lang.Specification

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

@Integration
class PagesSpec extends Specification {

    void "the public page #path renders for a visitor"() {
        when:
        def response = get(newClient(), path)

        then:
        response.statusCode() == 200
        response.body().contains('id="mainNav"')

        where:
        path << ['/', '/teams/list', '/sessions/list', '/player/list', '/playgrounds/list', '/site/stats', '/site/about',
                 '/auth/login']
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

    private URI url(String path) {
        URI.create("http://localhost:${serverPort}${path}")
    }
}
