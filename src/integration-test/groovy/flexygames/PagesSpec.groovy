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
        response.headers().firstValue('Location').orElse('').contains('/auth/login')
    }

    void "a seed user signs in and opens a private page"() {
        given:
        def client = newClient()

        when:
        def signIn = client.send(
                HttpRequest.newBuilder(url('/auth/signIn'))
                        .header('Content-Type', 'application/x-www-form-urlencoded')
                        .POST(HttpRequest.BodyPublishers.ofString('username=turman&password=gluar'))
                        .build(),
                HttpResponse.BodyHandlers.ofString())
        def account = get(client, '/myself/myAccount')

        then:
        signIn.statusCode() == 302
        signIn.headers().firstValue('Location').orElse('').endsWith('/home')
        account.statusCode() == 200
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
