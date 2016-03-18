
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<div class="body">
		<h1><g:message code="remindPassword.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if><br />
        <p><g:message code="remindPassword.info" /></p>
        <br>
		<g:form action="sendPasswordReset">
			<table>
				<tr>
					<td><g:message code="username" /></td>
					<td><g:textField name="username"/></td>
				</tr>
				<tr>
					<td><g:message code="email" /></td>
					<td><g:textField name="email"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="${message(code:'send')}"></td>
				</tr>
			</table>
		</g:form>
</body>
</html>
