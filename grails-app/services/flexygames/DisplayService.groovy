package flexygames

import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class DisplayService {

    static transactional = false

    def isMobileDevice(request) {
        if ('mobile'.equals(request.session.flavour)) {
            return true
        } else if ('desktop'.equals(request.session.flavour)) {
            return false
        } else {
            def device = request.getAttribute('currentDevice')
            if (device != null && device.isMobile()) {
                return true
            } else {
                return false
            }
        }
    }
}
