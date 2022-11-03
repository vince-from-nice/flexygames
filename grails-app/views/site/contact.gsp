<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
    <h1><g:message code="contact.title" /></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	<g:hasErrors bean="${contactForm}">
		<div class="errors">
		    <g:renderErrors bean="${contactForm}" as="list" />
		</div>
	</g:hasErrors>
    <g:form controller="site">
	    <table>
	    	<tr class="fieldcontain ${hasErrors(bean: contactForm, field: 'email', 'error')} required">
	    		<td><g:message code="contact.email" /></td>
	    		<g:set var="email" value="" />
	    		<g:if test="${request.currentUser}"><g:set var="email" value="${request.currentUser.email}" /></g:if>
	    		<td><g:textField name="email" size="30" value="${email}" /></td>
	    	</tr>
	    	<tr class="fieldcontain ${hasErrors(bean: contactForm, field: 'subject', 'error')} required">
	    		<td><g:message code="contact.subject" /></td>
	    		<td><g:textField name="subject" size="30" /></td>
	    	</tr>
	    	<tr class="fieldcontain ${hasErrors(bean: contactForm, field: 'body', 'error')} required">
	    		<td><g:message code="contact.body" /></td>
	    		<td><g:textArea name="body" style="width: 500px" /></td>
	    	</tr>
			<tr class="fieldcontain ${hasErrors(bean: contactForm, field: 'botChalenge', 'error')} required">
				<td style="width: 20%"><g:message code="contact.botChalenge" /></td>
				<td><g:textField name="botChalenge" size="3" /></td>
			</tr>
	    	<tr> 
	    		<td colspan="2" style="text-align: center;"><g:actionSubmit name="contact" action="contact" value="${message(code:'send')}"/></td>
	    	</tr>
	    </table>
    </g:form>
</body>
</html>
