<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<p class="breadcrumb"><g:link action="stats" id="${playerInstance.id}"><g:message code="player.stats.title.bySession.backToGlobalStats" /></g:link></p>
	<div class="page-header">
		<h1><g:message code="player.stats.title" /> <g:link action="show" id="${playerInstance.id}">${playerInstance}</g:link></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<section class="card">
		<h2><g:message code="player.stats.title.forSessionGroup" args="[group]" /></h2>
		<div class="table-wrap">
			<table class="flexyTab">
				<tr>
					<th><g:message code="date" /></th>
					<th><g:message code="team" /></th>
					<th><g:message code="group" /></th>
					<th class="status-head"><g:message code="player.show.status" /></th>
					<th class="number"><g:message code="wins" /></th>
					<th class="number"><g:message code="draws" /></th>
					<th class="number"><g:message code="defeats" /></th>
					<th class="number"><g:message code="actions" /></th>
					<th class="number"><g:message code="votes" /></th>
				</tr>
				<g:set var="userParticipations" value="${playerInstance.getEffectiveParticipationsBySessionGroup(group)}" />
				<g:if test="${userParticipations.size() > 0}">
					<g:render template="/player/participations" model="['userParticipations': userParticipations, 'withTotals': true, 'withAllCols': true]" />
				</g:if>
				<g:else>
					<tr>
						<td colspan="9" class="muted"><g:message code="player.show.noParticipations" /></td>
					</tr>
				</g:else>
			</table>
		</div>
	</section>
</body>
</html>
