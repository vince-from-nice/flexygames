package flexygames.interceptor

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class  LoggingInterceptor {

    LoggingInterceptor() {
        matchAll().excludes(controller:"assets")
    }

	boolean before() {
        if (controllerName != 'images' && controllerName != 'css' && controllerName != 'js') {
            // keep init time for stats
            request.setProperty("timeBeforeController", System.currentTimeMillis())

            // logging every action, big brother is watching you !
            def username = SecurityUtils.getSubject().getPrincipal().toString()
            if (username == "null") username = "anonymous (" + request.remoteAddr + ")"
            println '**************************************************************************************************************'
            println (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " FlexyGames : User $username is doing " + controllerName + "/" + actionName)
            println '**************************************************************************************************************'
        }
        true
    }

    boolean after() {
        // keep current time for stats
        request.setProperty("timeAfterController", System.currentTimeMillis())
        true
    }

    void afterView() {
        // no-op
    }
}
