<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card">
		<h1><g:message code="remindPassword.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<p class="muted"><g:message code="remindPassword.info" /></p>
		<g:form action="sendPasswordReset">
			<div class="field">
				<label for="username"><g:message code="username" /></label>
				<g:textField name="username" autocomplete="username" />
				<p class="field-help"><g:message code="remindPassword.usernameTips" args="[cr]"/></p>
			</div>
			<p class="form-separator"><g:message code="or" /></p>
			<div class="field">
				<label for="email"><g:message code="email" /></label>
				<g:textField name="email" autocomplete="email" />
			</div>
			<input type="submit" value="${message(code:'send')}">
		</g:form>
	</div>
</body>
</html>
