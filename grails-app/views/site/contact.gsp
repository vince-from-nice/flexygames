<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card">
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
			<div class="field ${hasErrors(bean: contactForm, field: 'email', 'error')}">
				<label for="email"><g:message code="contact.email" /></label>
				<g:textField name="email" value="${contactForm?.email ?: request.currentUser?.email}" autocomplete="email" required="" />
			</div>
			<div class="field ${hasErrors(bean: contactForm, field: 'subject', 'error')}">
				<label for="subject"><g:message code="contact.subject" /></label>
				<g:textField name="subject" value="${contactForm?.subject}" required="" />
			</div>
			<div class="field ${hasErrors(bean: contactForm, field: 'body', 'error')}">
				<label for="body"><g:message code="contact.body" /></label>
				<g:textArea name="body" value="${contactForm?.body}" rows="8" required="" />
			</div>
			<div class="field field-short ${hasErrors(bean: contactForm, field: 'botChalenge', 'error')}">
				<label for="botChalenge"><g:message code="contact.botChalenge" /></label>
				<g:textField name="botChalenge" inputmode="numeric" />
			</div>
			<g:actionSubmit name="contact" action="contact" value="${message(code:'send')}"/>
		</g:form>
	</div>
</body>
</html>
