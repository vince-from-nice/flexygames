<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="desktop" />
</head>
<body>
	<h1>
		<g:message code="admin.title" default="Administration" />
	</h1>
	<br />
	<g:if test="${message}">
		<div class="message">
			${message}
		</div>
	</g:if>
	<g:if test="${error}">
		<div class="errors">
			${error}
		</div>
	</g:if>
	<g:message code="admin.refreshAllPlayersCounters" />
	<g:link action="refreshPlayerCounters">
		<input type="button" value="Refresh" class="button" />
	</g:link>
	<br />
	<br />
	<g:form controller="admin">
		<g:message code="admin.findPlayer" />
		<g:textField name="playerToken" />
		<g:actionSubmit value="Find" action="findPlayer"  />
	</g:form>
	<br />
	<table>
	<g:each in="${users}" var="u">
		<tr>
			<td>${u.username}</td>
			<td><g:link controller="player" action="show" id="${u.id}">View</g:link></td>
			<td><g:link controller="user" action="edit" id="${u.id}">Edit</g:link></td>
			<td>${u.firstName}</td>
			<td>${u.lastName}</td>
			<td><a href="mailto:${u.email}">${u.email}</a></td>
		</tr>
	</g:each>
	</table>
	<br />
	<br />
	<br />
</body>
</html>
