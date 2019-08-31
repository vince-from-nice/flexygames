package flexygames.interceptor

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class DisplayInterceptor {

    def displayService

    DisplayInterceptor() {
        matchAll().excludes(controller:"assets")
    }

	boolean before() {
        if (controllerName && controllerName != 'images' && controllerName != 'css'
                && controllerName != 'js' && controllerName != 'favicon.ico') {
            // If user forces flavour via the "flavour" request parameter, store it into the session
            def flavour = request.getParameter('flavour')
            if (flavour != null) {
                request.session.flavour = flavour
            }
        }
        true
    }

    boolean after() {
        if (controllerName != 'images' && controllerName != 'css' && controllerName != 'js') {
            // Ignore calendar request which is failing on some users
            // (Impossible de créer une session après que la réponse ait été envoyée)
            if (controllerName == 'player' && actionName == 'cal') {
                return
            }
            // Set the display attribute (useful for some views)
            if (displayService.isMobileDevice(request)) {
                request.display = 'mobile'
            } else {
                request.display = 'desktop'
            }
            //println "Display is set to " + request.display
        }
        true
    }

    void afterView() {
        // no-op
    }
}
