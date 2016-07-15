package flexygames

import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist
import org.springframework.context.MessageSource;

class ForumService {

	def grailsApplication
	
	MessageSource messageSource
	
	def mailerService
	
    def SessionComment postSessionComment(User user, Session session, String text) throws Exception  {
		def comment = new SessionComment(user: user, session: session, date: new Date(), text: text)
		if (!text) throw new Exception("message is empty")
		// clean the input before insert it into DB
		comment.text = comment.text.replace(System.getProperty("line.separator"), "<br>" + System.getProperty("line.separator"))
		comment.text = new Jsoup().clean(comment.text, Whitelist.basicWithImages())
		if (comment.save(flush: true) && user.updateCommentCounter(1)) {
			// notify by email users who are watching that session
			def watches = SessionWatcher.findAllBySession(session)
			def emails = watches*.user.email
			if (emails.size() > 0) {
				// TODO get Locale from user profile
				def locale = new Locale("fr")
				def title = messageSource.getMessage('mails.newComment.title', [user.username].toArray(), locale)
				def body = messageSource.getMessage('mails.newComment.body', [
					user.username,
					'' + grailsApplication.config.grails.serverURL + '/sessions/show/' + session.id,
					session].toArray(), locale)
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
					SessionWatcher watch = new SessionWatcher(user: user, session: session)
					if (!watch.save()) {
						throw new Exception(watch.errors)
					}
				}
		} else {
			if (alreadyWatched) {
				SessionWatcher watch = SessionWatcher.findByUserAndSession(user, session)
				watch.delete()
			} else {
				throw new Exception("Hey you cannot unwatch that session because you're not watching it ! :)")
			}
		}
	}

	def BlogComment postBlogComment(User user, BlogEntry blogEntry, String text) throws Exception {
		def comment = new BlogComment(user: user, blogEntry: blogEntry, date: new Date(), text: text)
		if (!text) throw new Exception("message is empty")
		// clean the input before insert it into DB
		comment.text = comment.text.replace(System.getProperty("line.separator"), "<br>" + System.getProperty("line.separator"))
		comment.text = new Jsoup().clean(comment.text, Whitelist.basicWithImages())
		if (!comment.save(flush: true) || !user.updateCommentCounter(1)) {
			throw new Exception(comment.errors)
		}
		return comment;
	}
}
