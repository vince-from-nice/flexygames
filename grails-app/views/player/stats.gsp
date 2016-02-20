<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<h1><g:message code="player.stats.title" /> <g:link action="show" id="${playerInstance.id}"><b>${playerInstance}</b></g:link></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
<br />
<h2><g:message code="player.stats.title.global" /></h2>
	<table>
	<tr>
		<td>
			<g:message code="player.stats.partCounter.present" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.DONE_GOOD.code)}</span>
			<br />
			<br />
			<g:message code="player.stats.partCounter.absent" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.UNDONE.code)}</span>
			<br />
			<br />
			<g:message code="player.stats.partCounter.gateCrashed" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.DONE_BAD.code)}</span>
		</td>
		<td>
			<g:message code="player.stats.partCounter.refused" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.REMOVED.code)}</span>
			<br />
			<br />
			<g:message code="player.stats.partCounter.waitingList" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.WAITING_LIST.code)}</span>
			<br />
			<br />
			<g:message code="player.stats.partCounter.pending" /> :
			<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipationsByStatus(flexygames.Participation.Status.REQUESTED.code)}</span>
		</td>
	</tr>
	</table>
	<br />
	<h2><g:message code="player.stats.title.bySessionGroup" /></h2>
       <table class="flexyTab">
       	<tr>
        	<th style="font-size: 16px; text-align: center; vertical-align: middle;" colspan="2"><g:message code="group" /></th>
        	<th style="font-size: 16px; text-align: center; vertical-align: middle;"><g:message code="sessions" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="rounds" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="wins" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="draws" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="defeats" /></th>
        	<th style="font-size: 16px; text-align: center; vertical-align: middle;"><g:message code="actions" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="stats.bySession" /></th>
        	<th style="font-size: 12px; text-align: center; vertical-align: middle;"><g:message code="stats.byRound" /></th>
        	<th style="font-size: 16px; text-align: center; vertical-align: middle;"><g:message code="votes" /></th>
       	</tr>
		<g:each in="${playerInstance.getAllSessionGroups()}" var="group">
			<g:set var="parts" value="${playerInstance.getEffectiveParticipationsBySessionGroup(group).size()}" />
			<g:if test="${parts > 0}">
				<g:set var="actions" value="${playerInstance.getActionsBySessionGroup(group).size()}" />
				<g:set var="rounds" value="${playerInstance.getRoundsBySessionGroup(group).size()}" />
				<g:set var="wins" value="${playerInstance.getWinsBySessionGroup(group).size()}" />
				<g:set var="draws" value="${playerInstance.getDrawsBySessionGroup(group).size()}" />
				<g:set var="defeats" value="${playerInstance.getDefeatsBySessionGroup(group).size()}" />
				<g:set var="groupLink" value="${createLink(controller: 'player', action: 'stats', id: playerInstance.id, absolute: true, params: ['groupId': group.id])}" />
				<tr style="height: 60px; margin: 0px; padding: 0px; border: solid black 1px; cursor: pointer; " onclick="document.location='${groupLink}'">
					<td style="vertical-align: middle;">
						<g:set var="team" value="${group.defaultTeams.first()}" />
						<g:link controller="teams" action="show" id="${team.id}">
							<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
						</g:link>
					</td>
					<td style="vertical-align: middle; ; text-align: left">
						${group}
					</td>
					<td style="vertical-align: middle; ; text-align: center; border-left: black solid 1px">
						${parts}
					</td>
					<td style="vertical-align: middle; ; text-align: center">
						${wins+draws+defeats}
					</td>
					<td style="vertical-align: middle; ; text-align: center">
						<nobr>
						<span style="font-size: 12px">
							<g:if test="${wins > 0 || draws > 0 || defeats > 0}">
								${wins}
								<g:set var="ratio" value="${wins/(wins+draws+defeats)}" />
									<g:if test="${ratio == 0}">(0%)</g:if>
									<g:if test="${ratio == 1}">(100%)</g:if>
									<g:if test="${0 < ratio && ratio < 1}">(${(100*ratio).toString().substring(0,2)}%)</g:if>
							</g:if>
						</span>
						</nobr>
					</td>
					<td style="vertical-align: middle; ; text-align: center">
						<nobr>
						<span style="font-size: 12px">
							<g:if test="${wins > 0 || draws > 0 || defeats > 0}">
								${draws}
								<g:set var="ratio" value="${draws/(wins+draws+defeats)}" />
									<g:if test="${ratio == 0}">(0%)</g:if>
									<g:if test="${ratio == 1}">(100%)</g:if>
									<g:if test="${0 < ratio && ratio < 1}">(${(100*ratio).toString().substring(0,2)}%)</g:if>
							</g:if>
						</span>
						</nobr>
					</td>
					<td style="vertical-align: middle; text-align: center">
						<nobr>
						<span style="font-size: 12px">
							<g:if test="${wins > 0 || draws > 0 || defeats > 0}">
								${defeats}
								<g:set var="ratio" value="${defeats/(wins+draws+defeats)}" />
									<g:if test="${ratio == 0}">(0%)</g:if>
									<g:if test="${ratio == 1}">(100%)</g:if>
									<g:if test="${0 < ratio && ratio < 1}">(${(100*ratio).toString().substring(0,2)}%)</g:if>
							</g:if>
						</span>
						</nobr>
					</td>
					<td style="vertical-align: middle; text-align: center; border-left: black solid 1px">${actions}</td>
					<td style="vertical-align: middle; text-align: center;">
						<g:if test="${parts > 0}"><g:formatNumber number="${actions/parts}" type="number" maxFractionDigits="2" /></g:if>
						<g:else>0</g:else>
					</td>
					<td style="vertical-align: middle; text-align: center;">
						<g:if test="${rounds > 0}"><g:formatNumber number="${actions/rounds}" type="number" maxFractionDigits="2" /></g:if>
						<g:else>0</g:else>
					</td>
					<td style="vertical-align: middle; text-align: center; border-left: black solid 1px">${playerInstance.getVotingScoreBySessionGroup(group)}</td>
				</tr>
			</g:if>
		</g:each>
		<g:set var="totalActions" value="${playerInstance.actions.size()}" />
		<g:set var="totalParts" value="${playerInstance.effectiveParticipations.size()}" />
		<g:set var="totalRounds" value="${playerInstance.rounds.size()}" />
		<tr>
			<th colspan="2"><g:message code="Total" /></th>
			<th style="text-align: center; border-left: black solid 1px">${playerInstance.effectiveParticipations.size()}</th>
			<th style="text-align: center;">${totalRounds }</th>
			<th style="text-align: center;">${totalWins}</th>
			<th style="text-align: center;">${totalDraws}</th>
			<th style="text-align: center;">${totalDefeats}</th>
			<th style="text-align: center; border-left: black solid 1px">${playerInstance.actions.size()}</th>
			<th style="text-align: center;">
				<g:if test="${totalParts > 0}"><g:formatNumber number="${totalActions/totalParts}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th style="text-align: center;">
				<g:if test="${totalRounds > 0}"><g:formatNumber number="${totalActions/totalRounds}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th style="text-align: center; border-left: black solid 1px">${playerInstance.votingScore}</th>
		</tr>
       </table>
</body>
</html>
