
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/layouts/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<div class="body">
		<h1><g:message code="resetPassword.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if><br />
		<g:form action="refreshPassword">
			<g:hiddenField name="id" value="${params.id}"/>
			<g:hiddenField name="token" value="${params.token}"/>
			<table>
				<tr>
					<td><g:message code="resetPassword.newPassword" /></td>
					<td><g:passwordField name="newPassword"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="${message(code:'update')}"></td>
				</tr>
			</table>
		</g:form>
</body>
</html>
