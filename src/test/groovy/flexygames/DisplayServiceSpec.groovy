package flexygames

import grails.testing.services.ServiceUnitTest
import org.springframework.mock.web.MockHttpServletRequest
import spock.lang.Specification

class DisplayServiceSpec extends Specification implements ServiceUnitTest<DisplayService> {

    static final String IPHONE = 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1'
    static final String WINDOWS = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'

    void "#device gets the mobile pages: #expected"() {
        given:
        def request = new MockHttpServletRequest()
        request.addHeader('User-Agent', userAgent)

        expect:
        service.isMobileDevice(request) == expected

        where:
        device           | userAgent                                                                                                                          || expected
        'iPhone'         | IPHONE                                                                                                                             || true
        'iPad'           | 'Mozilla/5.0 (iPad; CPU OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1' || true
        'Android phone'  | 'Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36'          || true
        'Android tablet' | 'Mozilla/5.0 (Linux; Android 13; SM-X710) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'                 || true
        'BlackBerry'     | 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+'                    || true
        'Windows'        | WINDOWS                                                                                                                            || false
        'Mac'            | 'Mozilla/5.0 (Macintosh; Intel Mac OS X 14_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Safari/605.1.15'             || false
        'Linux'          | 'Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0'                                                         || false
    }

    void "a request without a User-Agent gets the desktop pages"() {
        expect:
        !service.isMobileDevice(new MockHttpServletRequest())
    }

    void "the #flavour flavour chosen in the session wins over the User-Agent"() {
        given:
        def request = new MockHttpServletRequest()
        request.addHeader('User-Agent', userAgent)
        request.session.setAttribute('flavour', flavour)

        expect:
        service.isMobileDevice(request) == expected

        where:
        flavour   | userAgent || expected
        'desktop' | IPHONE    || false
        'mobile'  | WINDOWS   || true
    }
}
