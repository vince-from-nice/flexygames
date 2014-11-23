package flexygames

import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist

class ForumService {

	def mailerService
	
    def Comment postComment(User user, Session session, String text) throws Exception  {
		def comment = new Comment(user: user, session: session, date: new Date(), text: text)
		// clean the input before insert it into DB
		comment.text = comment.text.replace(System.getProperty("line.separator"), "<br>" + System.getProperty("line.separator"))
		comment.text = new Jsoup().clean(comment.text, Whitelist.basicWithImages())
		if (comment.save(flush: true) && user.updateCommentCounter(1)) {
			// notify by email users who are watching that session
			def watches = SessionWatch.findAllBySession(session)
			def emails = watches*.user.email
			if (emails.size() > 0) {
				def title = message(code:'mails.newComment.title', args:[user.username])
				def body = message(code:'mails.newComment.body', args:[
					user.username,
					'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
					session])
				body = body.replace("BODY_STRING", comment.text)
				mailerService.mail(emails, title, body)
			}
		} else {
			throw new Exception(comment.errors)
		}
		return comment
    }
	
	def watchSessionComments(User user, Session session, Boolean wantToWatch) throws Exception {
		def alreadyWatched = user.isWatchingSession(session)
		if (wantToWatch) {
				if (alreadyWatched) {
					throw new Exception("Hey you're already watching that session")
				} else {
					SessionWatch watch = new SessionWatch(user: user, session: session)
					if (!watch.save()) {
						throw new Exception(watch.errors)
					}
				}
		} else {
			if (alreadyWatched) {
				SessionWatch watch = SessionWatch.findByUserAndSession(user, session)
				watch.delete()
			} else {
				throw new Exception("Hey you cannot unwatch that session because you're not watching it ! :)")
			}
		}
	}
}