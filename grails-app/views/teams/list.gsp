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
		<h1>
			<g:message code="team.list.title" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<table class="flexyTab">
			<thead>
				<tr>
					<th></th>
					<g:sortableColumn property="name"
						title="${message(code: 'name', default: 'Name')}" />
					<g:sortableColumn property="city"
						title="${message(code: 'city', default: 'City')}" />
					<th style="text-align: right;"><g:message code="members" /></th>
					<th style="text-align: right;"><g:message code="sessions" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${teamInstanceList}" status="i" var="teamInstance">
					<g:set var="teamLink"
						value="${createLink(controller: 'teams', action: 'show', id: teamInstance.id, absolute: true)}" />
					<tr class="${(i % 2) == 0 ? 'odd' : 'even'}"
						style="height: 50px; cursor: pointer"
						onclick="document.location='${teamLink}'">
						<td style="vertical-align: middle; text-align: right; margin: 0px; padding: 0px;">
							<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:teamInstance.logoName)}" alt="Team logo" />
						</td>
						<td style="text-align: left; vertical-align: middle;">
							${fieldValue(bean: teamInstance, field: "name")}
						</td>
						<td style="text-align: left; vertical-align: middle;">
							${teamInstance.city}
						</td>
						<td style="text-align: right; vertical-align: middle;"><b>
								${teamInstance.members.size()}
						</b> <g:message code="team.list.withXmanagers"
								args="[teamInstance.managers.size()]" /></td>
						<td style="text-align: right; vertical-align: middle;"><b>
								${teamInstance.countSessions()}
						</b> <g:message code="team.list.withXgroups"
								args="[teamInstance.sessionGroups.size()]" /></td>
					</tr>
				</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${teamInstanceTotal}" />
		</div>
	</div>
</body>
</html>
