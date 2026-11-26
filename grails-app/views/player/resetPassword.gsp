<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card">
		<h1><g:message code="resetPassword.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:form action="refreshPassword">
			<g:hiddenField name="id" value="${params.id}"/>
			<g:hiddenField name="token" value="${params.token}"/>
			<div class="field">
				<label for="newPassword"><g:message code="resetPassword.newPassword" /></label>
				<g:passwordField name="newPassword" autocomplete="new-password" required="" />
			</div>
			<input type="submit" value="${message(code:'update')}">
		</g:form>
	</div>
</body>
</html>
