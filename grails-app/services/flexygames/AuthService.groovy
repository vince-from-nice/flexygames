package flexygames

import grails.gorm.transactions.Transactional
import org.grails.web.util.WebUtils

@Transactional
class AuthService {

    def logonUser(User user) {
        println "User $user.username is logged in"
        def onlineUsers = WebUtils.retrieveGrailsWebRequest().currentRequest.session.servletContext.onlineUsers
        if (onlineUsers == null) {
            println "Init the online users list..."
            onlineUsers = new TreeSet<User>()
            WebUtils.retrieveGrailsWebRequest().currentRequest.session.servletContext.onlineUsers = onlineUsers
        }
        if (!onlineUsers*.username.contains(user.username)) {
            println "Adding $user.username to online users"
            onlineUsers.add(user)
        }
        user.lastLogin = new Date()
        if (!user.save()) println "Unable to update last login for $user.username"
    }

    def logoutUser(User user) {
        println "User $user.username is logged out"
        def onlineUsers = WebUtils.retrieveGrailsWebRequest().currentRequest.session.servletContext.onlineUsers;
        if (onlineUsers*.username.contains(user.username)) {
            onlineUsers.remove(user)
        }
    }
}
