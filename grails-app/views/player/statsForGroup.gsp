<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/layouts/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<h1><g:message code="player.stats.title" /> <g:link action="show" id="${playerInstance.id}"><b>${playerInstance}</b></g:link></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<br>
	<h2><g:message code="player.stats.title.forSessionGroup"  args="[group]" /></h2>
	[<g:link action="stats" id="${playerInstance.id }"><g:message code="player.stats.title.bySession.backToGlobalStats" /></g:link>]
	<br>&nbsp;
	<table class="flexyTab" style="width: 100%">
		<tr>
			<th valign="top" rowspan="1"><g:message code="date" /></th>
			<th valign="top" rowspan="1"><g:message code="team" /></th>
			<th valign="top" rowspan="1"><g:message code="group" /></th>
			<th valign="top" rowspan="1"><g:message code="player.show.status" /></th>
			<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="wins" /></th>
			<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="draws" /></th>
			<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="defeats" /></th>
			<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="actions" /></th>
			<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="votes" /></th>
		</tr>
		<g:set var="userParticipations" value="${playerInstance.getEffectiveParticipationsBySessionGroup(group)}" />
		<g:if test="${userParticipations.size() > 0}">
			<g:render template="/player/participations" model="['userParticipations': userParticipations, 'withTotals': false]" />
		</g:if>
		<g:else>
			<tr>
				<td colspan="4"><i><g:message code="player.show.noParticipations" /></i></td>
			</tr>
		</g:else>
	</table>
</body>
</html>
