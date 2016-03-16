import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils

import flexygames.User

class LoggingFilters {
	
	def filters = {
		
		all(uri: "/**") {

			before = {

				if (controllerName != 'assets') {
					
					// keep init time for stats
					request.setProperty("timeBeforeController", System.currentTimeMillis())

					// logging every action, big brother is watching you !
					def username = SecurityUtils.getSubject().getPrincipal().toString()
					if (username == "null") username = "anonymous"
					println '**************************************************************************************************************'
					println (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " FlexyGames : User $username is doing " + controllerName + "/" + actionName)
					println '**************************************************************************************************************'

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
