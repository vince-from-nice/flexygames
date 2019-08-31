package flexygames.interceptor

import org.apache.shiro.SecurityUtils

import flexygames.User

class OnlineUserInterceptor {

    OnlineUserInterceptor() {
        matchAll().excludes(controller:"assets")
    }

	boolean before() {
        if (controllerName && controllerName != 'images' && controllerName != 'css'
                && controllerName != 'js' && controllerName != 'favicon.ico') {
            // If there is a user currently logged in
            def username = SecurityUtils.getSubject().getPrincipal().toString()
            if (username != "null" && username != "anonymous") {
                def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
                // if user isn't not already in session (which could happen with the "remember me" feature?), do it now
                if (user.username != session.currentUser?.username) {
                    println "Adding $username into session"
                    session.currentUser = user
                }
                // Set the current user in the request scope
                request.currentUser = user
            }
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
