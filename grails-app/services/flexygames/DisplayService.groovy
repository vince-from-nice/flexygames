package flexygames

import jakarta.servlet.http.HttpServletRequest

import java.util.regex.Pattern

class DisplayService {

    static transactional = false

    // Phones, tablets and handhelds get the mobile pages, every Android and iOS device included.
    private static final Pattern MOBILE_USER_AGENT =
            ~/(?i)Mobi|Android|iPhone|iPad|iPod|BlackBerry|BB10|Bada|PlayStation Portable|Windows Phone|IEMobile|Opera Mini|webOS|Symbian/

    boolean isMobileDevice(HttpServletRequest request) {
        def flavour = request.session.getAttribute('flavour')
        if (flavour == 'mobile') {
            return true
        }
        if (flavour == 'desktop') {
            return false
        }
        String userAgent = request.getHeader('User-Agent')
        return userAgent != null && MOBILE_USER_AGENT.matcher(userAgent).find()
    }
}
