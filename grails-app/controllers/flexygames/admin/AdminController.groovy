package flexygames.admin

import org.apache.shiro.SecurityUtils

import flexygames.User;

class AdminController {

    def index = {        
    }

	def  refreshPlayerCounters = {
		for (User user in User.getAll()) {
			user.countParticipations()
			user.countAbsences()
			user.countGateCrashes()
			user.countComments()
		}
		flash.message = "Ok, counters has been refreshed for all players !"
		return redirect(controller: 'admin', action: 'index')
	}
	
	def findPlayer = {
		def t = '%' + params.playerToken + '%'
		def users = User.findAllByUsernameIlikeOrFirstNameIlikeOrLastNameIlikeOrEmailIlike(t, t, t, t)
		render (view: "index", model: [users: users, message: "" + users.size() + " user(s) has been found."])
	}
}
