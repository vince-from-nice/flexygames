package flexygames

import groovy.json.JsonSlurper;

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils
import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist
import org.springframework.dao.DataIntegrityViolationException

import com.lucastex.grails.fileuploader.UFile

class ManagerController {

	def mailerService

	/*********************************************************************************************
	 * Session basic management
	 *********************************************************************************************/

	def createSession = {
		SessionGroup groupInstance = SessionGroup.get(params.id)
		if (!groupInstance) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!groupInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session group (and add a new session) since you're not a manager !"
			return redirect(controller: "sessions", action: "list")
		}
		Session sessionInstance = new Session()
		sessionInstance.setGroup(groupInstance)
		sessionInstance.setDate(new Date() + 2)
		sessionInstance.setType(groupInstance.getDefaultType())
		sessionInstance.setPlayground(groupInstance.getDefaultPlayground())
		render(view: "sessionForm", model: [sessionInstance: sessionInstance])
	}

	def addSession = {
		SessionGroup groupInstance = SessionGroup.get(params.group.id)
		if (!groupInstance) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!groupInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session group (and add a new session) since you're not a manager !"
			return redirect(controller: "sessions", action: "list")
		}
		def sessionInstance = new Session(params)
		sessionInstance.setCreator(user);
		sessionInstance.setCreation(new Date())
		if (sessionInstance.save(flush: true)) {
			// By default add 2 reminders at -24h and -72h
			def reminder1 = new Reminder(minutesBeforeSession: 60 * 24, session: sessionInstance)
			def reminder2 = new Reminder(minutesBeforeSession: 60 * 72, session: sessionInstance)
			if (reminder1.save(flush: true) && reminder2.save(flush: true) ) {
				flash.message = "Ok session $sessionInstance.id has been created !"
			} else {
				flash.message = "Ok session $sessionInstance.id has been created.. but not its default reminders !"
			}
			redirect(controller:"sessions", action: "show", id: sessionInstance.id)
		}
		else {
			render(view: "sessionForm", model: [sessionInstance: sessionInstance])
		}
	}

	def editSession = {
		def sessionInstance = Session.get(params.id)
		if (!sessionInstance) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!sessionInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: sessionInstance.id])
		}
		render(view: "sessionForm", model: [sessionInstance: sessionInstance])
	}

	def updateSession = {
		def sessionInstance = Session.get(params.id)
		if (!sessionInstance) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!sessionInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: sessionInstance.id])
		}
		if (params.version) {
			def version = params.version.toLong()
			if (sessionInstance.version > version) {

				sessionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [
					message(code: 'session.label', default: 'Session')]
				as Object[], "Another user has updated this Session while you were editing")
				render(view: "sessionForm", model: [sessionInstance: sessionInstance])
				return
			}
		}
		sessionInstance.properties = params
		// Eventuellement on ajoute un reminder
		if (params.minutesForNewReminder) {
			def reminder = new Reminder(minutesBeforeSession: 60 * Integer.parseInt(params.minutesForNewReminder), session: sessionInstance)
			sessionInstance.reminders.add(reminder)
		}
		if (!sessionInstance.hasErrors() && sessionInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.updated.message', args: [message(code: 'session.label', default: 'Session'), sessionInstance.id])}"
			redirect(controller:"sessions", action: "show", id: sessionInstance.id)
		}
		else {
			render(view: "sessionForm", model: [sessionInstance: sessionInstance])
		}
	}
	
	def deleteReminder = {
		def reminder = Reminder.get(params.id)
		if (!reminder) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def sessionInstance = reminder.session
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!sessionInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: sessionInstance.id])
		}
		reminder.delete(flush: true)
		flash.message = "Ok reminder has been deleted !"
		render(view: "sessionForm", model: [sessionInstance: sessionInstance])
	}

	def duplicateSession = {
		Session oldSession = Session.get(params.id)
		if (!oldSession) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!oldSession.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: oldSession.id])
		}
		if (Session.findByGroupAndDate(oldSession.group, oldSession.date + 7)) {
			flash.error = "Hey a session already exists in the same group for the next week !!"
			return redirect(controller:"sessions", action: "show", id: oldSession.id)
		}
		Session newSession = new Session(group: oldSession.group, type: oldSession.type, playground: oldSession.playground,
		date: oldSession.date + 7, duration: oldSession.duration, rdvBeforeStart: oldSession.rdvBeforeStart,
		creation: new Date(), creator: user)
		if (!newSession.hasErrors() && newSession.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'session.label', default: 'Session'), newSession.id])}"
			// duplicate related reminders too
			oldSession.reminders.each { currentReminder ->
				def newReminder = new Reminder(session: newSession, minutesBeforeSession: currentReminder.minutesBeforeSession, jobExecuted: false)
				if (newReminder.hasErrors() || !newReminder.save(flush: true)) {
					flash.message << "<br/>Sorry, an error has occured on duplicating $currentReminder (details: $newReminder.errors)"
				}
			}
			redirect(controller:"sessions", action: "show", id: newSession.id)
		} else {
			flash.error = "Sorry, an error has occured on duplicating $oldSession (details: $newSession.errors)"
			redirect(controller:"sessions", action: "show", id: oldSession.id)
		}
	}

	def deleteSession = {
		def sessionInstance = Session.get(params.id)
		if (!sessionInstance) {
			flash.error = message(code: 'default.not.found.message', args: [
				message(code: 'session.label', default: 'Session'),
				params.id
			])
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!sessionInstance.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: sessionInstance.id])
		}
		// Decrement participation and posts counters for participants
		for (User player : sessionInstance.getEffectiveParticipants()) {
			player.updatePartCounter(-1)
		}
		for (User player : sessionInstance.getParticipantsByStatus(Participation.Status.UNDONE.code)) {
			player.updateAbsenceCounter(-1)
		}
		for (User player : sessionInstance.getParticipantsByStatus(Participation.Status.DONE_BAD.code)) {
			player.updateGateCrashCounter(-1)
		}
		for (Comment comment : sessionInstance.comments) {
			comment.user.updateCommentCounter(-1)
		}
		try {
			sessionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'session.label', default: 'Session'),
				params.id
			])
			return redirect(controller: "sessions", action: "list")
		} catch (DataIntegrityViolationException e) {
			flash.error = message(code: 'default.not.deleted.message', args: [
				message(code: 'session.label', default: 'Session'),
				params.id
			])
			redirect(controller:"sessions", action: "show", id: sessionInstance.id)
		}
	}
	
	/*********************************************************************************************
	 * Session participations management
	 *********************************************************************************************/

	def requestExtraPlayer = {
		def s = Session.get(params.id)
		if (!s) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!s.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def newPlayer = (params.internalUserId.length() > 0 ? User.get(params.internalUserId) : User.get(params.externalUserId))
		if (!newPlayer) {
			flash.error = "Unable to find user with id = $params.id !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def oldParticipation = Participation.findByPlayerAndSession(newPlayer, s)
		if (oldParticipation) {
			flash.error = "$newPlayer is already a participant of the session !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def newParticipation = new Participation(player: newPlayer, session:s,
		statusCode: Participation.Status.REQUESTED.code,
		//activityLog: new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()) + " : participation is " + Participation.Status.REQUESTED.code
		lastUpdate: new Date(), lastUpdater: user.username)
		if (newParticipation.save()) flash.message = "Ok $newPlayer is now a participant for $s"
		else flash.error = "Sorry, there's a error with $newPlayer participation !<br><br>$newParticipation.errors"
		redirect(controller: "sessions", action: "show", id: params.id)
	}

	def requestAllRegulars = { return requestMissingPlayers(true) }

	def requestAllTourists = { return requestMissingPlayers(false) }

	def requestMissingPlayers = { boolean regular ->
		def s = Session.get(params.id)
		if (!s) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!s.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def teams = s.group.defaultTeams
		def newPlayers = []
		// create a new participation for users of the group's default teams if it's needed
		teams.each{ team ->
			team.memberships.each { ms ->
				def alreadyExists = false
				s.participations.each { participation ->
					if (participation.player == ms.user) {
						alreadyExists = true
					}
				}
				if (!alreadyExists) {
					// checked user membership for the team
					if ((!s.group.competition && (regular ? ms.regularForTraining : !ms.regularForTraining))
					|| (s.group.competition && (regular ? ms.regularForCompetition : !ms.regularForCompetition))) {
						def newParticipation = new Participation(player: ms.user, session: s,
						statusCode: Participation.Status.REQUESTED.code,
						lastUpdate: new Date(), lastUpdater: user.username)
						newParticipation.save(flush: true)
						newPlayers << ms.user
					}
				}
			}
		}
		flash.message = "Participations has been created for all players of the following teams : $teams.<br /><br />Following users has been requested for the first time : $newPlayers"
		redirect(controller: "sessions", action: "show", id: params.id)
	}

	def approveAvailableParticipants = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def emails = []
		session.participations.each{ p ->
			if (p.statusCode == Participation.Status.AVAILABLE.code) {
				p.statusCode = Participation.Status.APPROVED.code
				p.userLog = "" // hmm on pourrait aussi garder le log initial du joueur
				p.setLastUpdate(new Date())
				p.setLastUpdater(user.username)
				emails << p.player.email
			}
		}
		// Notify by email the players whose status has been updated
		if (emails.empty) {
			flash.error = "There's no available players to update !"
			return redirect(controller: "sessions", action: "show", id: params.id)
		}
		def title = message(code:'mail.statusUpdateNotification.title', args:[
			message(code: "participation.status." + Participation.Status.APPROVED.code, locale: new Locale("en","Us")),
			session
		])
		def body = message(code:'mail.statusUpdateNotification.body', args:[
			user.username,
			'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
			session,
			message(code: "participation.status." + Participation.Status.APPROVED.code, locale: new Locale("en","Us")),
			session.group.defaultTeams.first().name
		])
		body = body.replace('USER_LOG', '')
		mailerService.mail(emails, title, body)
		// And save the session
		if (session.save()) {
			flash.message = "Ok participations has been updated !"
		} else {
			flash.error = "Sorry, an error has occured.<br><br>$session.errors"
		}
		redirect(controller: "sessions", action: "show", id: params.id)
	}

	def validateApprovedParticipants = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		// Check session is in the past
		if (session.date > new Date()) {
			flash.error = "Session has not started yet, you cannot validate player participations !"
			return redirect(controller: "sessions", action: "show", id: params.id)
		}
		def emails = []
		// For each approved participation
		session.participations.each{ p ->
			if (p.statusCode == Participation.Status.APPROVED.code) {
				// Update its status (+ log + counter)
				p.statusCode = Participation.Status.DONE_GOOD.code
				p.userLog = ""
				p.setLastUpdate(new Date())
				p.setLastUpdater(user.username)
				if (!p.player.updatePartCounter(1)) {
					flash.error = "Sorry, an error has occured when updating participation counter : $p.player.errors"
					redirect(controller: "sessions", action: "show", id: params.id)
				}
				emails << p.player.email
			}
		}
		// Notify by email the players whose status has been updated
		if (emails.empty) {
			println "No player need to be notified by email about his status update"
			flash.error = "There's no approved players to update !"
			return redirect(controller: "sessions", action: "show", id: params.id)
		}
		def title = message(code:'mail.statusUpdateNotification.title', args:[
			message(code: "participation.status." + Participation.Status.DONE_GOOD.code, locale: new Locale("en","Us")),
			session
		])
		def body = message(code:'mail.statusUpdateNotification.body', args:[
			user.username,
			'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
			session,
			message(code: "participation.status." + Participation.Status.DONE_GOOD.code, locale: new Locale("en","Us")),
			session.group.defaultTeams.first()
		])
		body = body.replace('USER_LOG', '')
		mailerService.mail(emails, title, body)
		// And save the session
		if (session.save()) {
			flash.message = "Ok participations has been updated !"
		} else {
			flash.error = "Sorry, an error has occured.<br><br>$session.errors"
		}
		redirect(controller: "sessions", action: "show", id: params.id)
	}

	def sendMessage = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		if (!params.message) {
			flash.error = "You cannot send an empty message !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def addresses = []
		if (params.recipients == "ALL_PARTICIPANTS") {
			session.participations.each { addresses << it.player.email }
		} else if (params.recipients == "AVAILABLE_PARTICIPANTS") {
			session.availableParticipants.each { addresses << it.email }
		} else if (params.recipients == "ONE_PARTICIPANT") {
			def player = User.get(params.recipientId)
			if (!player) {
				flash.message = "Emails has been sent to session players."
				redirect(controller:"sessions", action: "show", id: session.id)
			}
			addresses << player.email
		}
		if (addresses.size() == 0) {
			flash.error = "There's no participants to mail to !"
			return redirect(controller:"sessions", action: "show", id: session.id)
		}
		def title = message(code:'mail.customizedMessage.title', args:[user.username])
		def info = params.message
		info = info.replace(System.getProperty("line.separator"), "<br>" + System.getProperty("line.separator"))
		info = new Jsoup().clean(info, Whitelist.basic())
		def body = message(code:'mail.customizedMessage.body', args:[
			user.username,
			'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
			session,
			session.group.defaultTeams.first()
		])
		body = body.replace("BODY_STRING", info)
		mailerService.mail(user.email, addresses, title, body)
		flash.message = "Mail has been sent to <b>" + addresses.size() + "</b> participant(s)."
		redirect(controller:"sessions", action: "show", id: session.id)
	}

	def sendGoGoGoMessage = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		def title = message(code:'mail.goGoGoMessage.title')
		def body = message(code:'mail.goGoGoMessage.body', args: [
			'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
			session,
			new SimpleDateFormat("HH:mm").format(session.date),
			session.playground
		])
		def addresses = []
		session.approvedParticipants.each { player -> addresses << player.email }
		if (addresses.size() == 0) {
			flash.error = "There's no <b>approved</b> participants to mail to ! Did you forget to approve participants before to launch the mail ?"
			return redirect(controller:"sessions", action: "show", id: session.id)
		}
		mailerService.mail(addresses, title, body)
		flash.message = "Mail has been sent to <b>" + addresses.size() + "</b> participant(s)."
		redirect(controller:"sessions", action: "show", id: session.id)
	}
	
	/*********************************************************************************************
	 * Session compositions management
	 *********************************************************************************************/

	def addComposition = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		Composition composition = new Composition(session: session, lastUpdate: new Date(), lastUpdater: user)
		session.addToCompositions(composition)
		if (session.save(flush: true)) {
			flash.message = "A new composition has been added to the session"
		} else {
			flash.error = "Sorry, unable to add a new composition to the session"
		}
		redirect(uri: "/sessions/show/" + session.id + "#compositionsDetailedZone")
	}
	
	def updateComposition = {
		def composition = Composition.get(params.id)
		if (!composition) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'composition.label', default: 'Composition'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!composition.session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: composition.session])
		}
		
		// Create a new composition
		composition.description = params["description"]
		composition.lastUpdate = new Date()
		composition.lastUpdater = user 
		
		// Delete all existing items
		/*composition.items.clear()
		composition.items.each { 
			composition.removeFromItems(it);
			it.delete() 
		}*/		
		def items = CompositionItem.findAllByComposition(composition)
		items.each{it.delete()}
		//composition.removeFromItems(items)		
		composition.save(flush: true)
		
		// Recreate an item for each player 
		println "data: " + params["data"]
		def jsonSlurper = new JsonSlurper()
		def compoData = jsonSlurper.parseText(params["data"])
		println "compo id: " + compoData['compositionId']
		def players = compoData['players']
		players.each { player ->
			CompositionItem item = new CompositionItem(player: player, composition: composition)
			item.x = player['x']
			item.y = player['y']
			composition.addToItems(item)
		}		
		if (composition.save(flush: true)) {
			flash.message = "Composition has been updated"
		} else {
			flash.error = "Sorry, unable to update composition"
		}
		redirect(uri: "/sessions/show/" + composition.session.id + "#compositionsDetailedZone")
	}
	
	def deleteComposition = {
		def composition = Composition.get(params.id)
		if (!composition) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'composition.label', default: 'Composition'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!composition.session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: composition.session])
		}
		composition.delete(flush: true)
		flash.message = "Composition has been deleted !"
		redirect(uri: "/sessions/show/" + composition.session.id + "#compositionsDetailedZone")
	}
	
	/*********************************************************************************************
	 * Session rounds management
	 *********************************************************************************************/

	def addRound = {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: params.id])
		}
		//def rounds = SessionRound.findAllBySession(session)
		SessionRound round = new SessionRound(session: session/*, index: rounds.size() + 1*/)
		session.addToRounds(round)
		if (session.save(flush: true)) {
			flash.message = "A new round has been added to the session"
		} else {
			flash.error = "Sorry, unable to add a new round to the session"
		}
		redirect(uri: "/sessions/show/" + session.id + "#scoresheetArea")
	}

	def deleteRound = {
		def round = SessionRound.get(params.id)
		if (!round) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'Round'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!round.session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: round.session.id])
		}
		def actions = GameAction.findAllBySessionRound(round)
		actions.each{it.delete()}
		def session = round.session
		session.removeFromRounds(round)
		if (!session.save()) {
			flash.error = "Sorry, unable to remove round from session"
			return redirect(controller:"sessions", action: "show", id: session.id)
		}
		round.delete(flush: true)
		flash.message = "Round has been deleted !"
		redirect(uri: "/sessions/show/" + session.id + "#scoresheetArea")
	}

	def updateRound = {
		def round = SessionRound.get(params.id)
		if (!round) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'Round'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!round.session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: round.session.id])
		}
		def session = round.session
		// delete ALL actions
		round.actions.clear()
		round.save(flush:true)
		// for each participants : reset his team and create his actions
		session.approvedParticipants.each { p ->
			round.removeFromPlayersForTeamA(p)
			round.removeFromPlayersForTeamB(p)
			//p.removeFromSessionRounds(round)
			if(params.get("player" + p.id + "Team") == "TeamA") round.addToPlayersForTeamA(p)
			if(params.get("player" + p.id + "Team") == "TeamB") round.addToPlayersForTeamB(p)
			//			if (!round.save(flush:true) || !p.save(flush:true)) {
			//				flash.message = "Sorry, unable to update round !<br/><br/>Detail : $round.errors"
			//				redirect(uri: "/sessions/show/" + session.id + "#scoresheetArea")
			//			}
			def scoreParam = params.get("player" + p.id + "Score")
			if (scoreParam) {
				def score = Integer.parseInt(scoreParam)
				if(score > 0) {
					for (i in 0..<score) {
						GameAction action = new GameAction(sessionRound: round, mainContributor: p)
						action.save()
					}
				}
			}
		}
		// create unattribued actions
		def unattribuedScoreForTeamA = Integer.parseInt(params.unattribuedScoreForTeamA)
		def unattribuedScoreForTeamB = Integer.parseInt(params.unattribuedScoreForTeamB)
		for (i in 0..<unattribuedScoreForTeamA) {
			new GameAction(sessionRound: round, mainContributor: null, forFirstTeamIfOrphelin: true).save()
		}
		for (i in 0..<unattribuedScoreForTeamB) {
			new GameAction(sessionRound: round, mainContributor: null, forFirstTeamIfOrphelin: false).save()
		}
		// save round
		if (round.save(flush:true)) flash.message = "Round has been successfuly updated"
		else flash.error = "Sorry, unable to update round !<br/><br/>Detail : $round.errors"
		redirect(uri: "/sessions/show/" + session.id + "#scoresheetArea")
	}

	def duplicateRound = {
		def oldRound = SessionRound.get(params.id)
		if (!oldRound) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'Session'), params.id])}"
			return redirect(controller: "sessions", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!oldRound.session.isManagedBy(user.username)) {
			flash.error = "You cannot manage that session since you're not a manager !"
			return redirect(controller: "sessions", action: "show", params: [id: oldRound.session.id])
		}
		def session = oldRound.session
		SessionRound newRound = new SessionRound(session: session/*, index: rounds.size() + 1*/)
		for (User p in oldRound.playersForTeamA) {
			newRound.addToPlayersForTeamA(p)
		}
		for (User p in oldRound.playersForTeamB) {
			newRound.addToPlayersForTeamB(p)
		}
		session.addToRounds(newRound)
		if (session.save(flush: true)) {
			flash.message = "A new duplicated round has been added to the session"
		} else {
			flash.error = "Sorry, unable to duplicate round for the session"
		}
		redirect(uri: "/sessions/show/" + session.id + "#scoresheetArea")
	}

	/*********************************************************************************************
	 * Team management
	 *********************************************************************************************/
	
	def changeTeamLogoSuccess = {
		Team team = Team.get(params.id)
		if (!team) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team')])}"
			return redirect(controller: "teams", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!team.isManagedBy(user.username)) {
			flash.error = "You cannot manage that team since you're not a manager !"
			redirect(controller:"teams", action: "show", id: team.id)
		}
		def UFile logo = UFile.get(params.ufileId)
		if (!logo) {
			flash.error = "Sorry, your new logo cannot be found"
		} else {
			team.logo = logo
			if (!team.save()) {
				flash.error = "Sorry, your new logo cannot be saved"
			} else {
				flash.message = "Your new logo has been uploaded"
			}
		}
		redirect(controller:"teams", action: "show", id: team.id)
	}

	def changeTeamLogoError = {
		Team team = Team.get(params.id)
		if (!team) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team')])}"
			return redirect(controller: "teams", action: "list")
		}
		flash.error = "Sorry, your new logo has NOT been uploaded ! Check size that size limit is repected and it has a valid filename extension (such as .jpg, .jpeg, .gif, .png)"
		redirect(controller:"teams", action: "show", id: team.id)
	}

	def updateMembership = {
		Membership ms = Membership.get(params.id)
		if (!ms) {
			flash.error = "Membership doesn't exist !"
			return redirect(controller: "teams", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!ms.team.isManagedBy(user.username)) {
			flash.error = "You cannot manage that team since you're not a manager !"
			redirect(controller:"teams", action: "show", id: ms.team.id)
		}
		ms.feesUpToDate = 'UpToDate' == params.feesUpToDate
		ms.regularForTraining = 'Regular' == params.regularForTraining
		ms.regularForCompetition = 'Regular' == params.regularForCompetition
		if (!ms.save()) {
			flash.message = "Sorry, unable to update membership !<br><br>$ms.errors"
		} else {
			flash.error = "Ok membership has been updated !"
		}
		redirect(controller:"teams", action: "show", id: ms.team.id)
	}

	def updateAllMemberships = {
		Team team = Team.get(params.id)
		if (!team) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team')])}"
			return redirect(controller: "teams", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!team.isManagedBy(user.username)) {
			flash.error = "You cannot manage that team since you're not a manager !"
			redirect(controller:"teams", action: "show", id: team.id)
		}
		team.memberships.each { ms ->
			if (params.with == 'cotizOk') ms.feesUpToDate = true
			if (params.with == 'cotizKo') ms.feesUpToDate = false
			if (params.with == 'regularForCompetition') ms.regularForCompetition = true
			if (params.with == 'regularForTraining') ms.regularForTraining = true
			if (params.with == 'touristForCompetition') ms.regularForCompetition = false
			if (params.with == 'touristForTraining') ms.regularForTraining = false
			if (!ms.save()) {
				flash.error = "Sorry, unable to update membership for $ms.username !<br><br>$ms.errors"
				return redirect(controller:"teams", action: "show", id: team.id)
			}
		}
		flash.message = "Ok all memberships has been updated !"
		redirect(controller:"teams", action: "show", id: team.id)
	}

	def removeMembership = {
		Membership ms = Membership.get(params.id)
		Team team = ms.team
		User player = ms.user
		if (!ms) {
			flash.error = "Membership doesn't exist !"
			return redirect(controller: "teams", action: "list")
		}
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!ms.team.isManagedBy(user.username)) {
			flash.error = "You cannot manage that team since you're not a manager !"
			redirect(controller:"teams", action: "show", id: ms.team.id)
		}
		def teamId = team.id
		try {
			team.removeFromMemberships(ms)
			player.removeFromMemberships(ms)
			team.save(flush: false)
			player.save(flush: false)
			//			ms.delete(flush: false)
			//			team.discard()
			//			user.discard()
			mailerService.mail(player.email, message(code:'management.membership.remove.mail.title'),
			message(code:'management.membership.remove.mail.body', args: [user.username, team.name]))
			flash.message = "Ok membership has been removed"
			redirect(controller:"teams", action: "show", id: teamId)
		} catch (Exception e) {
			flash.error ="Ooops sorry, unable to remove membership : " + e.getMessage()
			redirect(controller:"teams", action: "show", id: teamId)
		}
	}

}
