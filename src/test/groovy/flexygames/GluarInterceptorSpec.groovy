package flexygames

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class GluarInterceptorSpec extends Specification implements InterceptorUnitTest<GluarInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test gluar interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"gluar")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
