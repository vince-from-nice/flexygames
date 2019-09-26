package flexygames

import grails.gorm.transactions.Transactional
import org.geeks.browserdetection.UserAgentIdentService

@Transactional(readOnly = true)
class DisplayService {

    static transactional = false

    UserAgentIdentService userAgentIdentService

    def isMobileDevice(request) {
        if ('mobile'.equals(request.session.flavour)) {
            return true
        } else if ('desktop'.equals(request.session.flavour)) {
            return false
        } else {
            if (userAgentIdentService.isMobile()) {
                return true
            } else {
                return false
            }
        }
    }
}
