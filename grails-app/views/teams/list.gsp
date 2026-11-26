<%@ page import="flexygames.Team"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
<g:set var="entityName"
	value="${message(code: 'team.label', default: 'Team')}" />
</head>
<body>
	<div class="body">
		<div class="page-header">
			<h1><g:message code="team.list.title" /></h1>
		</div>
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
		<div class="table-wrap">
		<table class="flexyTab">
			<thead>
				<tr>
					<th></th>
					<g:sortableColumn property="name" title="${message(code: 'name', default: 'Name')}" />
					<g:sortableColumn property="city" title="${message(code: 'city', default: 'City')}" />
					<th class="number"><g:message code="members" /></th>
					<th class="number"><g:message code="sessions" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${teamInstanceList}" status="i" var="teamInstance">
					<g:set var="teamLink" value="${createLink(controller: 'teams', action: 'show', id: teamInstance.id, absolute: true)}" />
					<tr class="${(i % 2) == 0 ? 'odd' : 'even'} clickable" onclick="document.location='${teamLink}'">
						<td class="team-cell"><flexy:teamLogo team="${teamInstance}" /></td>
						<td><g:link action="show" id="${teamInstance.id}" class="player-name">${fieldValue(bean: teamInstance, field: "name")}</g:link></td>
						<td>${teamInstance.city}</td>
						<td class="number">
							<strong>${teamInstance.members.size()}</strong>
							<span class="small muted"><g:message code="team.list.withXmanagers" args="[teamInstance.managers.size()]" /></span>
						</td>
						<td class="number">
							<strong>${teamInstance.countSessions()}</strong>
							<span class="small muted"><g:message code="team.list.withXgroups" args="[teamInstance.sessionGroups.size()]" /></span>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		</div>
		<div class="pagination">
			<g:paginate total="${teamInstanceTotal}" />
		</div>
	</div>
</body>
</html>
