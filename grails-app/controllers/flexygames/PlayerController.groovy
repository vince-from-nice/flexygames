package flexygames

import java.text.SimpleDateFormat
import java.util.regex.Matcher


import net.fortuna.ical4j.model.DateTime
import net.fortuna.ical4j.model.TimeZoneRegistry
import net.fortuna.ical4j.model.TimeZoneRegistryFactory
import net.fortuna.ical4j.model.component.VTimeZone

import org.apache.shiro.crypto.hash.Sha512Hash

class PlayerController {

	def mailerService
	
	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list = {
		if (!params.max || params.max == 'null') params.max = 20
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		if(!params.sort) params.sort = "username"
		if(!params.order) params.order = "asc"
		def users = User.list(params)
		def total = User.count()
		if (params.sort == "username") {
			if (!params.first) params.first = ''
			users = User.findAllByUsernameIlike(params.first + "%", params)
			total = User.countByUsernameIlike(params.first + "%")
		}
//		if (params.sort == "firstName") {
//			users = User.findAllByFirstNameIlike(params.first + "%", params)
//			total = User.countByFirstNameIlike(params.first + "%")
//		} else if (params.sort == "lastName") {
//			users = User.findAllByLastNameIlike(params.first + "%", params)
//			total = User.countByLastNameIlike(params.first + "%")
//		} else if (params.sort == "company") {
//			users = User.findAllByCompanyIlike(params.first + "%", params)
//			total = User.countByCompanyIlike(params.first + "%")
//		} else if (params.sort == "city") {
//			users = User.findAllByCityIlike(params.first + "%", params)
//			total = User.countByCityIlike(params.first + "%")
//		} 
		[playerInstanceList: users, playerInstanceTotal: total]
	}
	
	def listOld = {
		if (!params.max || params.max == 'null') params.max = 20
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		if(!params.sort) params.sort = "username"
		if(!params.order) params.order = "asc"
		def users = User.list(params)
		//		println "\tUser.count() returns " + User.count()
		//		println "\tUser list size is " + users.size()
		[playerInstanceList: users, playerInstanceTotal: User.count()]
	}

	def show = {
		def playerInstance = User.get(params.id)
		if (!playerInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])}"
			redirect(action: "list")
		}
		else {
			[playerInstance: playerInstance]
		}
	}

	def stats = {
		def playerInstance = User.get(params.id)
		if (!playerInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])}"
			redirect(action: "list")
		}
		else {
			if (params.groupId) {
				def SessionGroup group = SessionGroup.get(params.groupId)
				if (!group) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])}"
				}
				return render(view: 'statsForGroup', model: [playerInstance: playerInstance, group: group])
			}
			[playerInstance: playerInstance]
		}
	}

	def register = {
//		def playerInstance = new User()
//		playerInstance.properties = params
//		return [playerInstance: playerInstance]
	}

	def save = {
		User user = new User(params)
		User similarUser = User.findByUsernameIlike(params.username.toLowerCase())
		if (similarUser) {
			flash.message = "${message(code:'register.similarUserAlreadyExists', args: [similarUser.username])}"
			return render(view: "register", model: [user: similarUser])
		}
		Matcher m = User.USERNAME_VALID_CHARS.matcher(params.username)
		if (!m.matches()) {
			flash.message = "${message(code: 'register.invalidUsername')}"
			return render(view: "register", model: [user: user])
		}
		if (!params.password || params.password.length() < 4) {
			flash.message = "${message(code: 'register.invalidPassword')}"
			return render(view: "register", model: [user: user])
		}
		Team team = Team.get(params.teamId)
		if (!team) {
			flash.message = "Team with id [$params.teamId] doesn't exist !"
			return render(view: "register", model: [user: user])
		}
		user.passwordHash = new Sha512Hash(params.password).toHex()
		user.firstName = params.firstName
		user.email = params.email.toLowerCase()
		user.registrationDate = new Date()
		user.addToRoles(Role.findByName("Player"))
		Membership ms = new Membership(user: user, team: team, manager: false,
			regularForTraining: true,
			regularForCompetition: false)
		user.addToMemberships(ms)
		if (!user.save(flush: true)) {
			flash.message = "${message(code: 'register.failed')}"
			return render(view: "register", model: [user: user])
		}
		flash.message = "${message(code: 'register.success')}"
		redirect(controller:"site", action: "home")
	}

	def remindPassword = {}

	def sendPasswordReset = {
		User user = User.findByUsernameOrEmail(params.username, params.email.toLowerCase())
		if (!user) {
			flash.message = "${message(code: 'remindPassword.userNotFound')}"
			return redirect(action: "remindPassword")
		}
		user.passwordResetToken = UUID.randomUUID().toString()
		user.passwordResetExpiration = new Date() + 1
		if (!user.save()) {
			flash.message = "Sorry, unable to save password token ! <br><br>$user.errors"
			return redirect(action: "remindPassword")
		}
		def body = 'Hi ' + user + ', for reset your password please follow that <a href="' +
					grailsApplication.config.grails.serverURL + '/player/resetPassword?id=' + user.id +
					'&token=' + user.passwordResetToken + '">link</a>.'
		mailerService.mail(user.email, "Scatterbrain !!", body)
//		sendMail {
//			to user.email
//			subject "[FlexyGames] Scatterbrain !!"
//			html body
//		}
		flash.message = "${message(code: 'remindPassword.success')}"
		redirect(controller:"site", action: "home")
	}

	def resetPassword = {
	}

	def refreshPassword = {
		User user = User.findByIdAndPasswordResetToken(params.id, params.token)
		if (!user) {
			flash.message = "${message(code: 'resetPassword.userNotFound')}"
			return redirect(action: "resetPassword")
		}
		if (user.passwordResetExpiration.before(new Date())) {
			flash.message = "${message(code: 'resetPassword.expiredToken')}"
			return redirect(action: "resetPassword")
		}
		user.passwordHash = new Sha512Hash(params.newPassword).toHex()
		user.passwordResetToken = "Reset already done"
		user.passwordResetExpiration = new Date()
		if (!user.save()) {
			flash.message = "Sorry, unable to save your new password ! <br><br>$user.errors"
			return redirect(action: "resetPassword")
		}
		flash.message = "${message(code: 'resetPassword.success')}"
		redirect(controller:"site", action: "home")
	}
	
	def cal = {
		def player = User.get(params.id)
		if (!player) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])}"
			redirect(action: "list")
		}
		if (player.calendarToken != params.token) {
			flash.message = "Sorry, your calendar link is invalid.. are you trying to spy $player ? :)"
			redirect(action: "show", id: player.id)
		}
		TimeZoneRegistry registry = TimeZoneRegistryFactory.instance.createRegistry()
		TimeZone timezone = registry.getTimeZone("Europe/Paris")
		VTimeZone tz = timezone.vTimeZone
		render(contentType: 'text/calendar') {
			calendar {
				events {
					for (Participation p in player.participationsVisibleInCalendar) {
						Session s = p.session
						Playground pg = s.playground
						DateTime start = new DateTime(s.rdvDate.getTime());
						start.setTimeZone(timezone);
						DateTime end = new DateTime(s.endDate.getTime());
						end.setTimeZone(timezone);
						event(
							start: start,
							end: end,
							//tzId: 'Europe/Paris',
							tzId: tz.timeZoneId,
							description: 'Session link : ' + grailsApplication.config.grails.serverURL + '/sessions/show/' + s.id,
							location: pg.name + ', ' + pg.postalAddress,
							streetAddress: pg.street,
							locality: pg.city, 
							summary: s.group.name
						) 
					}
				}
			}
		}
		// TODO mettre un bon filename dans la réponse
		response.addHeader("content-disposition", String.format("attachment;filename=%s", "FlexyCalendarFor"+player.username + ".ics"))
		println new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " FlexyGames : Calendar generated for $player"
	}
}
