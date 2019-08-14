package flexygames

import grails.gorm.transactions.Transactional
import org.springframework.context.MessageSource

@Transactional
class ReminderService {

	//static transactional = false
	
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
					// TODO get Locale from user profile
					def locale = new Locale("fr")
					def team = session.group.defaultTeams.first()
					def updateUrl= grailsApplication.config.grails.serverURL + '/sessions/updateFromMail/' + session.id
					def sessionUrl= grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id
					def teamUrl = grailsApplication.config.grails.serverURL + '/teams/show/' + team.id
					// there was an issue with variables replacement, need to retest
					def title = messageSource.getMessage("mail.requestNotification.title", [] as Object[], locale)
					def body = messageSource.getMessage("mail.requestNotification.body", [] as Object[], locale)
					body = body.replace("{0}", updateUrl)
					body = body.replace("{1}", sessionUrl)
					body = body.replace("{2}", session.toString())
					body = body.replace("{3}", teamUrl)
					body = body.replace("{4}", team.toString())
					title = title.replace("{0}", session.group.toString())
					//def body = grailsApplication.getMainContext().getMessage("mail.requestNotification.body", null, "", LCH.getLocale())
					//def body = getApplicationTagLib().message(code:'mail.requestNotification.body', bodyArgs)
					if (!emails.empty) {
						mailerService.mail(emails, title, body)
					} else {
						println "Ok nothing to do, no player need to be reminded"
					}
					reminder.jobExecuted = true
					reminder.save()
				}
			}
		}
	}
	
}
