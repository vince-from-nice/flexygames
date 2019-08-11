package flexygames.interceptor

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class OnlineUserInterceptor {

    OnlineUserInterceptor() {
        matchAll().excludes(controller:"assets")
    }

	boolean before() {
        if (controllerName != 'images' && controllerName != 'css' && controllerName != 'js') {
            if (servletContext.onlineUsers == null) {
                println "Init online user list..."
                servletContext.onlineUsers = new TreeSet<User>()
            }
            // TODO code temporaire pour mettre la liste dans le scope request (et non application)
            // car le servletApplication est null dans certaines gsp, bug de grails 2.0 ?
            request.onlineUsers = servletContext.onlineUsers

            // If there is a user currently logged in
            def username = SecurityUtils.getSubject().getPrincipal().toString()
            if (username != "null" && username != "anonymous") {
                def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
                // if user isn't not already in the online user list (which could happen with the "remember me" feature), do it now !
                def onlineUsers = servletContext.onlineUsers
                if (!onlineUsers*.username.contains(username)) {
                    println "Adding $username to online users"
                    onlineUsers << user
                }
                // if user isn't not already in session (which could happen with the "remember me" feature), do it now !
                if (session.currentUser != user ) {
                    println "Adding $username into session"
                }
                // Actually need to update the user in session in any case (lazy proxies can have a valid Hibernate session)
                session.currentUser = user
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
