package flexygames

import grails.gorm.transactions.Transactional
import org.apache.shiro.crypto.hash.Sha512Hash

class MyselfController {

	def displayService
	
    def index() {
        redirect(action: "myAccount", params: params)
    }

	def myAccount() {
		User user = request.currentUser
		render(view: (displayService.isMobileDevice(request) ? 'myAccountMobile' : 'myAccount'),  model:[playerInstance: user])
	}
	
	def myPlanning() {
		User user = request.currentUser
		// if calendarToken is not already generated do it now !
		if (!user.calendarToken) {
			user.calendarToken = UUID.randomUUID().toString()
			if (!user.save()) {
				flash.message = "Sorry, unable to generate user calendar token ! <br><br>$user.errors"
				return redirect(controller:"site", action: "home")
			}
		}
		render (view:"myPlanning", model:[player: user])
	}
	
	def mySessions() {
		User user = request.currentUser
		Calendar cal = Calendar.getInstance()
		final int WEEKS_NBR = 4;
		def allSessions = [];
		int year = (params.year ? Integer.parseInt(params.year) : cal.get(Calendar.YEAR))
		def firstWeek = (params.week ? Integer.parseInt(params.week) : cal.get(Calendar.WEEK_OF_YEAR))
		cal.set(Calendar.YEAR, year)
		cal.set(Calendar.WEEK_OF_YEAR, firstWeek)
		for (i in 0..<WEEKS_NBR) {
			def week = firstWeek + i
//			cal.set(Calendar.YEAR, year)
//			cal.set(Calendar.WEEK_OF_YEAR, week)
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY)
			cal.set(Calendar.HOUR_OF_DAY, 0)
			cal.set(Calendar.MINUTE, 0)
			cal.set(Calendar.SECOND, 0)
			Date start = cal.getTime()
			//cal.set(Calendar.WEEK_OF_YEAR, week + 1)
			cal.add(Calendar.DAY_OF_YEAR, 7)
			Date end = cal.getTime()
			def sessions = user.getAllSubscribedSessions(start, end)
			//println "start: $start"
			//println "end: $end"
			allSessions.add(sessions)
		}
		render (view:"mySessions", model:[allSessions: allSessions, year: year, week: firstWeek])
	}

	def myProfile() {
		User user = request.currentUser
		redirect (controller:"player", action:"show", id: user.id)
	}
	
	def myStats() {
		User user = request.currentUser
		redirect(controller: "player", action: "stats", params:[id:user.id])
	}
	
	def editMyProfile() {
		[playerInstance: request.currentUser]
	}

	@Transactional
	def updateMyProfile() {
		User user = request.currentUser
		if (user) {
			if (params.version) {
				def version = params.version.toLong()
				if (user.version > version) {
					user.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'player.label', default: 'Player')]
					as Object[], "Another user has updated this Player while you were editing")
					render(view: "editMyProfile", model: [playerInstance: user])
					return
				}
			}
            user.properties = params
            user.save()
			user.properties = params
			if (!user.hasErrors() && user.save()) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'player.label', default: 'Player'), user.username])}"
				redirect(action: "myAccount")
			}
			else {
				render(view: "editMyProfile", model: [playerInstance: user])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), user.username])}"
			redirect(action: "myAccount")
		}
	}

	@Transactional
	def changeMyPassord() {
		User user = request.currentUser
		if (user) {
			def oldPasswordHash = new Sha512Hash(params.oldPassword).toHex()
			if (user.passwordHash != oldPasswordHash) {
				flash.message = "Sorry, wrong old password !"
			} else {
				user.passwordHash = new Sha512Hash(params.newPassword).toHex()
				if (user.save()) {
					flash.message = "Ok your new password has been saved !"
				} else {
					flash.message = "Sorry, your new password hasn't been saved.<br><br>$user.errors"
				}
			}
		} else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.username])}"
		}
		redirect(action: "myAccount")
	}

	@Transactional
	def joinTeam() {
		User user = request.currentUser
		def team = Team.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player')])}"
			redirect(action: "list")
		} else if (!team) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team')])}"
			redirect(action: "myAccount")
		} else if (user.allSubscribedTeams.contains(team)) {
			flash.message = "Hey you've already joined $team !"
			redirect(action: "myAccount")
		} else {
			def regularString = message(code:'regular')
			Membership ms = new Membership(user: user, team: team, manager: false,
					regularForTraining: params.regularForTraining == regularString,
					regularForCompetition: params.regularForCompetition == regularString)
			if (ms.save()) flash.message = "Ok you have joined $ms.team"
			else flash.message = "Sorry, you haven't joined $team.<br><br>$ms.errors"
			redirect(action: "myAccount")
		}
	}

	@Transactional
	def updateMembership() {
		User user = request.currentUser
		def ms = Membership.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player')])}"
			redirect(action: "list")
		} else if (!ms) {
			flash.message = "Sorry but you don't have any membership with that team !"
			redirect(action: "myAccount")
		} else {
			def regularString = message(code:'regular') 
			ms.regularForTraining = (params.regularForTraining == regularString)
			ms.regularForCompetition = (params.regularForCompetition == regularString)
			if (ms.save()) flash.message = "Ok you have updated your membership for $ms.team"
			else flash.message = "Sorry, you haven't updated your membership for $team.<br><br>$ms.errors"
			redirect(action: "myAccount")
		}
	}

	@Transactional
	def leaveTeam () {
		//User user = request.currentUser
		User user = request.currentUser
		def ms = Membership.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player')])}"
			return redirect(action: "list")
		}
		if (!ms) {
			flash.message = "Sorry but you don't have any membership with that team !"
			return redirect(action: "myAccount")
		} 
		def teamName = ms.team.name
		user.removeFromMemberships(ms)
		if (!user.save()) {
			flash.message = "Unable to leave that team !<br>$user.errors"
			return redirect(action: "myAccount")
		}
		ms.delete()
		flash.message = "Ok you have left $teamName"
		redirect(action: "myAccount")
	}

	@Transactional
	def addSkill() {
		User user = request.currentUser
		GameSkill skill = GameSkill.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player')])}"
			redirect(action: "list")
		} else if (!skill) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill')])}"
			redirect(action: "myAccount")
		} else if (user.skills.contains(skill)) {
			flash.message = "You already have the skill $skill"
			render(view: "myAccount", model:  [playerInstance: user])
		} else {
			user.addToSkills(skill)
			user.save()
			flash.message = "$user has a new skill : $skill"
			render(view: "myAccount", model:  [playerInstance: user])
		}
	}

	@Transactional
	def removeSkill() {
		User user = request.currentUser
		GameSkill skill = GameSkill.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player')])}"
			redirect(action: "list")
		} else if (!skill) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill')])}"
			redirect(action: "myAccount")
		} else if (!user.skills.contains(skill)) {
			flash.message = "Error : $user doesn't have the skill $skill"
			redirect(action: "myAccount")
		} else {
			user.removeFromSkills(skill)
			user.save()
			flash.message = "$user doesn't have the skill $skill anymore"
			redirect(action: "myAccount")
		}
	}

	def changeAvatarSuccess() {
		flash.message = "Your new avatar has been uploaded"
		redirect(action: "myAccount")
	}

	def changeAvatarError() {
		flash.message = "Sorry, your new avatar has NOT been uploaded : $flash.message"
		redirect(action: "myAccount")
	}
}
