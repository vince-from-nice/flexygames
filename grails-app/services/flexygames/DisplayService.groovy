package flexygames

import grails.transaction.Transactional

@Transactional
class DisplayService {

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
