package flexygames

import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist
import org.springframework.context.MessageSource;

class ForumService {

	def grailsApplication
	
	MessageSource messageSource
	
	def mailerService

	def static URL_START_TOKENS = ['http:', 'https:']

	// Don't success to add to char list a range of chars even with ['a'..'z'].collect() ! :(
	def char[] URL_VALID_CHARS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
						   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
						   '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
						   '-', '.', '_', '~', ':', '/', '?', '#', '[', ']', '@', '!', '$', '&', '\'', '(', ')', '*', '+', ',', ';', '=', '%']

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

	/**
	 * Enhance text of session comments by replacing parts which look like an URL by a real HTML tag (ie. <a href="">...</a>).
	 */
	def enhanceText(SessionComment comment) {
		def text = new String(comment.text)
		for (String token in URL_START_TOKENS) {
			def i = text.indexOf(token)
			if (i >= 0) {
				def chars = text.getChars()
				def j = i
				for (; j < text.length(); j++) {
					println "gluar " + chars[j]
					if (!URL_VALID_CHARS.contains(chars[j])) {
						break;
					}
				}
				String url = text.substring(i, j)
				String link = '<a href="' + url + '">' + url + '</a>'
				//text.replace(url, link)
				text = text.substring(0, i) + link + text.substring(j)
			}
		}
		comment.enhancedText = text
	}
}
