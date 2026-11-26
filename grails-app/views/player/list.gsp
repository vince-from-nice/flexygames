<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="player.list.title" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>

	<nav class="letter-filter" aria-label="${message(code: 'player.list.findPlayer')}">
		<span class="letter-filter-label"><g:message code="player.list.findPlayer" /></span>
		<g:link action="list" params="[first: '']" class="${params.first ? '' : 'active'}"><g:message code="All" /></g:link>
		<g:each in="${('A'..'Z')}" var="first">
			<g:link action="list" params="[first: first]" class="${params.first == first ? 'active' : ''}">${first}</g:link>
		</g:each>
	</nav>

	<div class="table-wrap">
	<table class="flexyTab player-table">
		<thead>
			<tr>
				<th></th>
				<g:sortableColumn property="username" title="${message(code: 'username', default: 'Username')}" />
				<g:sortableColumn property="firstName" class="col-optional" title="${message(code: 'firstName', default: 'First Name')}" />
				<g:sortableColumn property="lastName" class="col-optional" title="${message(code: 'lastName', default: 'Last Name')}" />
				<g:sortableColumn property="company" class="col-optional" title="${message(code: 'company', default: 'Company')}" />
				<g:sortableColumn property="city" class="col-optional" title="${message(code: 'city', default: 'City')}" />
				<th><g:message code="teams" /></th>
				<g:sortableColumn property="participationCounter" class="number" title="${message(code: 'participations', default: 'Participations')}" />
				<g:sortableColumn property="votingScoreCounter" class="number" title="${message(code: 'votes', default: 'Votes')}" />
				<g:sortableColumn property="commentCounter" class="number" title="${message(code: 'comments', default: 'Comments')}" />
				<g:sortableColumn property="registrationDate" class="col-optional" title="${message(code: 'registration', default: 'Registration Date')}" />
				<g:sortableColumn property="lastLogin" class="col-optional" title="${message(code: 'lastLogin', default: 'Last login')}" />
			</tr>
		</thead>
		<tbody>
			<g:each in="${playerInstanceList}" status="i" var="playerInstance">
				<g:set var="playerLink" value="${createLink(controller: 'player', action: 'show', id: playerInstance.id, absolute: true)}" />
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'} clickable" onclick="document.location='${playerLink}'">
					<td class="avatar-cell"><g:render template="/common/avatar" model="[player: playerInstance]" /></td>
					<td><g:link action="show" id="${playerInstance.id}" class="player-name">${fieldValue(bean: playerInstance, field: "username")}</g:link></td>
					<td class="col-optional small">${fieldValue(bean: playerInstance, field: "firstName")}</td>
					<td class="col-optional small">${fieldValue(bean: playerInstance, field: "lastName")}</td>
					<td class="col-optional small">${fieldValue(bean: playerInstance, field: "company")}</td>
					<td class="col-optional small">${fieldValue(bean: playerInstance, field: "city")}</td>
					<td class="small">
						<g:each in="${playerInstance.allSubscribedTeams}" var="t" status="j">${j > 0 ? ', ' : ''}<g:link controller="teams" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></g:each>
					</td>
					<td class="number">${playerInstance.participationCounter}</td>
					<td class="number">${playerInstance.votingScoreCounter}</td>
					<td class="number">${playerInstance.commentCounter}</td>
					<td class="col-optional small muted"><g:formatDate date="${playerInstance.registrationDate}" format="yyyy-MM-dd" /></td>
					<td class="col-optional small muted"><g:formatDate date="${playerInstance.lastLogin}" format="yyyy-MM-dd" /></td>
				</tr>
			</g:each>
		</tbody>
	</table>
	</div>

	<div class="pagination">
		<g:paginate total="${playerInstanceTotal}" params="${['first': params.first]}" />
	</div>
</body>
</html>
