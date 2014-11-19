package flexygames


import grails.util.Environment

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder as LCH


class ReminderService {

	static transactional = false // pour éviter un spam général
	
	def grailsApplication
	
	MessageSource messageSource
	
	def mailerService

	def remindParticipants() {
		def sessions = Session.findAllByDateGreaterThanEquals(new Date())
		sessions.each{ session ->
			int minutesBeforeSession = (session.date.time - (new Date()).time) / (60 * 1000)
			String delay = "$minutesBeforeSession minutes"
			if (minutesBeforeSession > 1440 * 3) {
				delay = ((int) minutesBeforeSession / 1440) + " days ($minutesBeforeSession minutes)"
			} else if (minutesBeforeSession > 60 * 3) {
				delay = ((int) minutesBeforeSession / 60) + " hours ($minutesBeforeSession minutes)"
			} 
			session.reminders.each { reminder ->
				def emails = []
				if (reminder.jobExecuted) {
					//println "\t$reminder is already executed"
				} else if (reminder.minutesBeforeSession > minutesBeforeSession) {
					println "$session has a $reminder which is not yet executed and reminder needs to trigger $reminder.minutesBeforeSession minutes before session start  => dot it now !! "
					session.participations.each { participation ->
						//println "\t\tParticipation status for player $p.player.username is $p.statusCode"
						if (participation.statusCode == Participation.Status.REQUESTED.code) {
							//println "\tParticipation for player $participation.player.username has the REQUESTED status, need to remind him"
							emails << participation.player.email
						}
					}
					// Putain c'est pas facile d'avoir l'i18n dans les services, surtout avec le remplacement des variables !
					def locale = new Locale("fr") // TODO récupérer la Locale depuis le profil du user
					//def title = grailsApplication.getMainContext().getMessage("mail.requestNotification.title", null, "", LCH.getLocale())
					def title = messageSource.getMessage("mail.requestNotification.title", null, locale)
					def body = messageSource.getMessage("mail.requestNotification.body", null, locale)
					body = body.replace("{0}", '' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id)
					body = body.replace("{1}", session.toString())
					title = title.replace("{0}", session.group.toString())
					//def body = grailsApplication.getMainContext().getMessage("mail.requestNotification.body", null, "", LCH.getLocale())
					//def body = getApplicationTagLib().message(code:'mail.requestNotification.body', bodyArgs)
					if (!emails.empty) {
						mailerService.mail(emails, title, body)
					} else {
						println "Ok nothing to do, no player need to be reminded"
					} 
					reminder.jobExecuted = true
					reminder.save(flush: true)
				}
			}
		}
	}
	
	// Just for i18n
//	def getApplicationTagLib(){
//		def ctx = ApplicationHolder.getApplication().getMainContext()
//		return ctx.getBean('org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib')
//	}
	
}
