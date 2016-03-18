import flexygames.User
import org.apache.shiro.SecurityUtils

class OnlineUserFilters {

    def filters = {

        all(controller:'*', action:'*') {
            before = {
                if (controllerName == 'assets') {
                    return
                }
                if (servletContext.onlineUsers == null) {
                    println "Init online user list..."
                    servletContext.onlineUsers = new TreeSet<User>()
                }
                // TODO code temporaire pour mettre la liste dans le scope request (et non application)
                // car le servletApplication est null dans certaines gsp, bug de grails 2.0 ?
                request.onlineUsers = servletContext.onlineUsers

                // check that authentificated user is present in online user list and in session
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
                        println "Adding $username to session"
                        session.currentUser = user
                    }
                }
            }

            after = { Map model ->

            }

            afterView = { Exception e ->

            }
        }
    }
}
