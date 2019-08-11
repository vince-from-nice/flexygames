package flexygames.command;

import grails.validation.Validateable;

// TODO @Validateable doesn't exist anymore in Grails 3.x ?
// @Validateable
public class ContactCommand {
	String email
	String subject
	String body
	
	static constraints = {
		email(blank: false, email: true)
		subject(blank: false, minSize: 2, maxSize: 100)
		body(blank: false, minSize: 2, maxSize: 10000)
	}
}
