package flexygames

import org.apache.shiro.SecurityUtils
import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist
import org.springframework.context.MessageSource;

class SessionService {

	def grailsApplication
	
	MessageSource messageSource
	
	def mailerService

	def join(User user, Session session) {
		// Check if the session isn't entered into locking mode (and is not in the past btw)
		if (new Date(session.date.time - session.group.lockingTime* 60 * 1000) < new Date()) {
			throw new Exception("Sorry, it's too late to join the session !!")
		}
		// Check if the user is not already a participant
		Participation oldParticipation = Participation.findByPlayerAndSession(user, session)
		if (oldParticipation) {
			throw new Exception("Hey you're already a participant to the session")
		}
		// Create and save a new participation
		def newParticipation = new Participation(player: user, session:session,
		statusCode: Participation.Status.AVAILABLE.code,
		lastUpdate: new Date(), lastUpdater: user.username)
		if (!newParticipation.save(flush:true)) {
			throw new Exception("Error on saving : " + newParticipation.errors)
		}
	}

	def updatePlayerStatus(User user, Participation participation, String newStatus, String userLogText) throws Exception  {

		///////////////////////////////////////////////////////////////////////////////////////////
		// Checking
		///////////////////////////////////////////////////////////////////////////////////////////

		// Checking if user is not admin or manager
		if (!SecurityUtils.getSubject().hasRole("Administrator")
		&& !participation.session.isManagedBy(user.username)) {
			// Standard users can use 3 status only
			if (newStatus != Participation.Status.REQUESTED.code &&
			newStatus != Participation.Status.AVAILABLE.code  &&
			newStatus != Participation.Status.DECLINED.code) {
				throw new Exception("Hey you're not a manager, you cannot set such status !!")
			}
			// Check that session isn't entered into locking mode (and is not in the past btw)
			if (new Date(participation.session.date.time - participation.session.group.lockingTime * 60 * 1000) < new Date()) {
				throw new Exception("Sorry, it's too late to update your status !!")
			}
			// Check user is changing his own status
			if (user != participation.player) {
				throw new Exception("Hey you cannot change status for others participants !!")
			}
		}

		// Checking if user is admin or manager
		else {
			// if new status is a reporting status, check session has begun
			if (participation.session.date > new Date() &&
			(newStatus == Participation.Status.DONE_GOOD.code ||
			newStatus == Participation.Status.DONE_BAD.code  ||
			newStatus == Participation.Status.UNDONE.code )) {
				throw new Exception("Hey you cannot set a reporting status if the session has not begun yet !!")
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////
		// Updating status
		///////////////////////////////////////////////////////////////////////////////////////////

		String oldStatusCode = participation.statusCode
		participation.setStatusCode(newStatus)
		participation.setLastUpdate(new Date())
		participation.setLastUpdater(user.username)
		// Truncate and clean the user log text before insert it into DB
		String userLog = userLogText
		if (!userLog || userLog == 'null') {
			userLog = ''
		}
		userLog = new Jsoup().clean(userLog, Whitelist.relaxed()) // damned <img> tags are not cleaned !
		userLog = userLog.substring(0, (userLog.length() > 100 ? 100 : userLog.length()))
		participation.setUserLog(userLog)
		if (participation.save()) {
			//flash.message = "Participation status for <b>$participation.player</b> has been successfuly updated !"
		} else {
			throw new Exception("Error on saving : " + participation.errors)
		}

		///////////////////////////////////////////////////////////////////////////////////////////
		// Email notification
		///////////////////////////////////////////////////////////////////////////////////////////

		// TODO get Locale from user profile
		def locale = new Locale("en","Us")
		
		// If the status update has not been performed by user itself, notify him by email
		if (user != participation.player) {
			def title = messageSource.getMessage('mail.statusUpdateNotification.title', [
				messageSource.getMessage("participation.status." + participation.statusCode, [].toArray(), locale), 
				participation.session
			].toArray(), locale)
			def body = messageSource.getMessage('mail.statusUpdateNotification.body', [
				user.username,
				'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + participation.session.id,
				participation.session,
				messageSource.getMessage("participation.status." + participation.statusCode, [].toArray(), locale),
				participation.session.group.defaultTeams.first()
			].toArray(), locale)
			body = body.replace("USER_LOG", participation.userLog)
			mailerService.mail(participation.player.email, title, body)
		}

		// If a non manager user change its status from APPROVED to DECLINED, notify managers by email
		if (oldStatusCode == Participation.Status.APPROVED.code && newStatus == Participation.Status.DECLINED.code
		&& !participation.session.isManagedBy(user.username)) {
			def title = messageSource.getMessage('mail.statusUpdateNotificationForManager.title', [user.username, participation.session])
			def body = messageSource.getMessage('mail.statusUpdateNotificationForManager.body', [
				user.username,
				'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + participation.session.id,
				participation.session,
				messageSource.getMessage("participation.status." + participation.statusCode, [].toArray(), locale)
			].toArray(), locale)
			body = body.replace("USER_LOG", participation.userLog)
			participation.session.managers.each{manager ->
				mailerService.mail(manager.email, title, body)
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////
		// Updating statistics
		///////////////////////////////////////////////////////////////////////////////////////////

		// If previous status was effective but new status is not, decrement player part counter
		if ((oldStatusCode == Participation.Status.DONE_GOOD.code || oldStatusCode == Participation.Status.DONE_BAD.code)
		&& (newStatus != Participation.Status.DONE_GOOD.code && newStatus != Participation.Status.DONE_BAD.code)) {
			participation.player.updatePartCounter(-1)
		}
		// If new status is effective but old status was not, increment player part counter
		if ((newStatus == Participation.Status.DONE_GOOD.code || newStatus == Participation.Status.DONE_BAD.code)
		&& (oldStatusCode != Participation.Status.DONE_GOOD.code && oldStatusCode != Participation.Status.DONE_BAD.code)) {
			participation.player.updatePartCounter(1)
		}
		// If new status is DONE_BAD, increment player gatecrash counter
		if (newStatus == Participation.Status.DONE_BAD.code) {
			participation.player.updateGateCrashCounter(1)
		}
		// If old status was DONE_BAD, decrement player gatecrash counter
		if (oldStatusCode == Participation.Status.DONE_BAD.code) {
			participation.player.updateGateCrashCounter(-1)
		}
		// If new status is UNDONE, increment player gatecrash counter
		if (newStatus == Participation.Status.UNDONE.code) {
			participation.player.updateAbsenceCounter(1)
		}
		// If old status was UNDONE, decrement player gatecrash counter
		if (oldStatusCode == Participation.Status.UNDONE.code) {
			participation.player.updateAbsenceCounter(-1)
		}
	}
}
