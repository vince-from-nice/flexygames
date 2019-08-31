package flexygames.interceptor

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class ShiroSecurityInterceptor {

    int order = HIGHEST_PRECEDENCE+100

    ShiroSecurityInterceptor() {
        matchAll()
    }

	boolean before() {
        // Ignore direct views (e.g. the default main index page).
        if (!controllerName) {
            return true
        }

        // turman: no access control for static resources
        if (controllerName == 'images' || controllerName == 'css'
                || controllerName == 'js' || controllerName == 'favicon.ico') {
            return true
        }

        // turman : no access control for some controllers.
        if (controllerName in ['auth', 'player', 'playgrounds', 'site', 'stats', 'teams', 'assets', 'fileUpload']) {
            return true
        }

        // turman : no access control for some controllers AND actions.
        if ((controllerName == 'sessions' && actionName == 'list') ||
                (controllerName == 'sessions' && actionName == 'show') ||
                (controllerName == 'sessions' && actionName == 'forecast') ||
                (controllerName == 'fileUploader' && actionName == 'show')) {
            return true
        }

        // turman: restrict access to team manager for some controllers
        // TOO DIFFICULT because access control are too much specific to action (so it's done in each action)
        //if (controllerName in ['manager']) { }

        // turman: admin controllers are restricted to users with the "Administrator" role
        // USELESS because Administrator role has already all permissions !
        //if (! controllerName in ['admin', 'stats', 'player', 'teams', 'playgrounds', 'sessions', 'fileUploader']) { }

        // Access control by convention.
        if (!accessControl()) {
            flash.message = "You need to be authenticated in order to do that action."
            return false
        }
        true
    }

    boolean after() {
        true
    }

    void afterView() {
        // no-op
    }
}
