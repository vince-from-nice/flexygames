package flexygames

import grails.gorm.transactions.Transactional

@Transactional
class AuthService {

    def logonUser(User user, def onlineUsers) {
        if (!onlineUsers*.username.contains(user.username)) onlineUsers.add(user)
        println "User $user.username is logged in"
        user.lastLogin = new Date()
        if (!user.save(flush: true)) println "Unable to update last login for $user.username"
    }

    def logoutUser(User user, def onlineUsers) {
        if (onlineUsers*.username.contains(user)) onlineUsers.remove(user)
        println "User $user.username is logged out"
    }
}
