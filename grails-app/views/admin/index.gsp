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
	<g:if test="${flash.message}">
		<div class="message">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">
			${flash.error}
		</div>
	</g:if>
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
	<g:form action="duplicateSessionGroup">
		<g:message code="admin.duplicateSessionGroup" />
		<g:select name="sessionGroupId" from="${flexygames.SessionGroup.list()}" optionKey="id" required="" />
		<input type="submit" value="Duplicate" class="button" />
	</g:form>
	<br />
	<br />
	<g:message code="admin.refreshAllPlayersCounters" />
	<g:link action="refreshPlayerCounters">
		<input type="button" value="Refresh" class="button" />
	</g:link>
	<br />
	<br />
	<br />
</body>
</html>
