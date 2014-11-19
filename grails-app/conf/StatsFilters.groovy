import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class StatsFilters {
	
	def filters = {
		
		all(uri: "/**") {
			
			before = {
				if (servletContext.onlineUsers == null) {
					println "Init online user list..."
					servletContext.onlineUsers = new TreeSet<User>()
				} 
				// TODO code temporaire pour mettre la liste dans le scope request (et non application)
				// car le servletApplication est null dans certaines gsp, bug de grails 2.0 ?
				request.onlineUsers = servletContext.onlineUsers
				
				if (controllerName != "fileUploader") {
					
					// keep init time for stats
					request.setProperty("timeBeforeController", System.currentTimeMillis())
					// logging every action, big brother is watching you !
					def username = SecurityUtils.getSubject().getPrincipal().toString()
					if (username == "null") username = "anonymous"
					println (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " FlexyGames : User $username is doing " + controllerName + "/" + actionName)
					

					// who's online
					def onlineUsers = servletContext.onlineUsers
					if (username != "anonymous") {
						// if user isn't not already in the online user list (which could happen with the "remember me" feature), do it now !
						if (!onlineUsers*.username.contains(username)) {
							println "Adding $username to online users"
							// put the user into the session (online user list will be updated)
							def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
							session.setAttribute("currentUser", user)
						}
					}
					
					//println "Time consumed by filter.before : " + ((Long) (System.currentTimeMillis() - request.getProperty("timeBeforeController"))) + " ms"
				}
			}
			
			after = {
				// keep current time for stats
				request.setProperty("timeAfterController", System.currentTimeMillis())
			}
		}
		
	}
	
}
