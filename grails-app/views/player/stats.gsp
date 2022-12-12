<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'userStats.player')}" />
</head>
<body>
	<h1><g:message code="player.stats.title" /> <g:link action="show" id="${userStats.player.id}"><b>${userStats.player}</b></g:link></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
<br />
<h2><g:message code="player.stats.title.global" /></h2>
	<table>
	<tr>
		<td>
			<g:message code="player.stats.partCounter.present" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.DONE_GOOD.code)}</b>
			<br />
			<br />
			<g:message code="player.stats.partCounter.absent" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.UNDONE.code)}</b>
			<br />
			<br />
			<g:message code="player.stats.partCounter.late" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.DONE_LATE.code)}</b>
			<br />
			<br />
			<g:message code="player.stats.partCounter.gateCrashed" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.DONE_BAD.code)}</b>
		</td>
		<td>
			<g:message code="player.stats.partCounter.refused" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.REMOVED.code)}</b>
			<br />
			<br />
			<g:message code="player.stats.partCounter.waitingList" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.WAITING_LIST.code)}</b>
			<br />
			<br />
			<g:message code="player.stats.partCounter.pending" /> :
			<b>${userStats.player.countParticipationsByStatus(flexygames.Participation.Status.REQUESTED.code)}</b>
		</td>
	</tr>
	</table>
	<br />
	<table>
		<tr>
			<td>
				<g:message code="player.stats.votingScoreCounter" /> :
				<b>${userStats.player.votingScoreCounter}</b>
			</td>
			<td>
				<g:message code="player.stats.sentVotes" /> :
				<b>${userStats.player.voteCounter}</b>
			</td>
		</tr>
		<tr>
			<td>
				<g:message code="player.stats.requestedCarpools" /> :
				<b>${userStats.player.countRequestedCarpools()}</b>
			</td>
			<td>
				<g:message code="player.stats.approvedCarpools" /> :
				<b>${userStats.player.countApprovedCarpools()}</b>
			</td>
		</tr>
	</table>
	<br />
	<h2><g:message code="player.stats.title.bySessionGroup" /></h2>
		<!-- use total counts just for check/fun -->
		<g:set var="totalParts" value="${0}" />
		<g:set var="totalActions" value="${0}" />
		<g:set var="totalRounds" value="${0}" />
		<g:set var="totalWins" value="${0}" />
		<g:set var="totalDraws" value="${0}" />
		<g:set var="totalDefeats" value="${0}" />
		<g:set var="totalVotes" value="${0}" />
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
		<g:each in="${userStats.sessionGroups}" var="group">
			<g:set var="actions" value="${group.actions}" />
			<g:set var="rounds" value="${group.rounds}" />
			<g:set var="wins" value="${group.wins}" />
			<g:set var="draws" value="${group.draws}" />
			<g:set var="defeats" value="${group.defeats}" />
			<g:set var="votingScore" value="${group.votingScore}" />
			<!-- increments total counts -->
			<g:set var="votingScore" value="${group.votingScore}" />
			<g:set var="totalActions" value="${totalActions + actions}" />
			<g:set var="totalRounds" value="${totalRounds + rounds}" />
			<g:set var="totalWins" value="${totalWins + wins}" />
			<g:set var="totalDraws" value="${totalDraws + draws}" />
			<g:set var="totalDefeats" value="${totalDefeats + defeats}" />
			<g:set var="totalVotes" value="${totalVotes + votingScore}" />
			<g:set var="parts" value="${group.effectiveParticipations}" />
			<g:if test="${parts > 0}">
				<g:set var="totalParts" value="${totalParts + parts}" />
				<g:set var="groupLink" value="${createLink(controller: 'player', action: 'stats', id: userStats.player.id, absolute: true, params: ['groupId': group.id])}" />
				<tr style="height: 60px; margin: 0px; padding: 0px; border: solid black 1px; cursor: pointer; " onclick="document.location='${groupLink}'">
					<td style="vertical-align: middle;">
						<g:set var="team" value="${group.firstDefaultTeam}" />
						<g:link controller="teams" action="show" id="${team.id}">
							<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
						</g:link>
					</td>
					<td style="vertical-align: middle; ; text-align: left">
						${group.name}
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
							<g:if test="${wins + draws + defeats > 0}">
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
							<g:if test="${wins + draws + defeats > 0}">
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
							<g:if test="${wins + draws + defeats > 0}">
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
					<td style="vertical-align: middle; text-align: center; border-left: black solid 1px">${votingScore}</td>
				</tr>
			</g:if>
		</g:each>
		<tr>
			<th colspan="2"><g:message code="Total" /></th>
			<th style="text-align: center; border-left: black solid 1px">${totalParts}</th>
			<th style="text-align: center;">${totalRounds }</th>
			<th style="text-align: center;">${totalWins}</th>
			<th style="text-align: center;">${totalDraws}</th>
			<th style="text-align: center;">${totalDefeats}</th>
			<th style="text-align: center; border-left: black solid 1px">${userStats.player.actions.size()}</th>
			<th style="text-align: center;">
				<g:if test="${totalParts > 0}"><g:formatNumber number="${totalActions/totalParts}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th style="text-align: center;">
				<g:if test="${totalRounds > 0}"><g:formatNumber number="${totalActions/totalRounds}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th style="text-align: center; border-left: black solid 1px">${totalVotes}</th>
		</tr>
       </table>
</body>
</html>
