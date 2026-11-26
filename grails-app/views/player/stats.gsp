<%@ page import="flexygames.User; flexygames.Participation"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'userStats.player')}" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="player.stats.title" /> <g:link action="show" id="${userStats.player.id}">${userStats.player}</g:link></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>

	<h2><g:message code="player.stats.title.global" /></h2>
	<g:set var="statusTiles" value="${[
			['player.stats.partCounter.present', Participation.Status.DONE_GOOD],
			['player.stats.partCounter.absent', Participation.Status.UNDONE],
			['player.stats.partCounter.late', Participation.Status.DONE_LATE],
			['player.stats.partCounter.gateCrashed', Participation.Status.DONE_BAD],
			['player.stats.partCounter.refused', Participation.Status.REMOVED],
			['player.stats.partCounter.waitingList', Participation.Status.WAITING_LIST],
			['player.stats.partCounter.pending', Participation.Status.REQUESTED]
	]}" />
	<div class="stat-tiles">
		<g:each in="${statusTiles}" var="tile">
			<div class="stat-tile">
				<strong>${userStats.player.countParticipationsByStatus(tile[1].code)}</strong>
				<span><span class="legend-dot" style="background-color: ${tile[1].color};"></span> <g:message code="${tile[0]}" /></span>
			</div>
		</g:each>
		<div class="stat-tile">
			<strong>${userStats.player.votingScoreCounter ?: 0}</strong>
			<span><g:message code="player.stats.votingScoreCounter" /></span>
		</div>
		<div class="stat-tile">
			<strong>${userStats.player.voteCounter ?: 0}</strong>
			<span><g:message code="player.stats.sentVotes" /></span>
		</div>
		<div class="stat-tile">
			<strong>${userStats.player.countRequestedCarpools()}</strong>
			<span><g:message code="player.stats.requestedCarpools" /></span>
		</div>
		<div class="stat-tile">
			<strong>${userStats.player.countApprovedCarpools()}</strong>
			<span><g:message code="player.stats.approvedCarpools" /></span>
		</div>
	</div>

	<section class="card">
	<h2><g:message code="player.stats.title.bySessionGroup" /></h2>
		<g:set var="totalParts" value="${0}" />
		<g:set var="totalActions" value="${0}" />
		<g:set var="totalRounds" value="${0}" />
		<g:set var="totalWins" value="${0}" />
		<g:set var="totalDraws" value="${0}" />
		<g:set var="totalDefeats" value="${0}" />
		<g:set var="totalVotes" value="${0}" />
       <div class="table-wrap">
       <table class="flexyTab">
       	<tr>
        	<th colspan="2"><g:message code="group" /></th>
        	<th class="number"><g:message code="sessions" /></th>
        	<th class="number"><g:message code="rounds" /></th>
        	<th class="number"><g:message code="wins" /></th>
        	<th class="number"><g:message code="draws" /></th>
        	<th class="number"><g:message code="defeats" /></th>
        	<th class="number"><g:message code="actions" /></th>
        	<th class="number"><g:message code="stats.bySession" /></th>
        	<th class="number"><g:message code="stats.byRound" /></th>
        	<th class="number"><g:message code="votes" /></th>
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
				<tr class="clickable" onclick="document.location='${groupLink}'">
					<td class="team-cell">
						<g:set var="team" value="${group.firstDefaultTeam}" />
						<g:link controller="teams" action="show" id="${team.id}">
							<flexy:teamLogo team="${team}" />
						</g:link>
					</td>
					<td>
						${group.name}
					</td>
					<td class="number">
						${parts}
					</td>
					<td class="number">
						${wins+draws+defeats}
					</td>
					<td class="number">
						<nobr>
						<span class="small muted">
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
					<td class="number">
						<nobr>
						<span class="small muted">
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
					<td class="number">
						<nobr>
						<span class="small muted">
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
					<td class="number">${actions}</td>
					<td class="number">
						<g:if test="${parts > 0}"><g:formatNumber number="${actions/parts}" type="number" maxFractionDigits="2" /></g:if>
						<g:else>0</g:else>
					</td>
					<td class="number">
						<g:if test="${rounds > 0}"><g:formatNumber number="${actions/rounds}" type="number" maxFractionDigits="2" /></g:if>
						<g:else>0</g:else>
					</td>
					<td class="number">${votingScore}</td>
				</tr>
			</g:if>
		</g:each>
		<tr class="counter-row">
			<th colspan="2"><g:message code="Total" /></th>
			<th class="number">${totalParts}</th>
			<th class="number">${totalRounds }</th>
			<th class="number">${totalWins}</th>
			<th class="number">${totalDraws}</th>
			<th class="number">${totalDefeats}</th>
			<th class="number">${userStats.player.actions.size()}</th>
			<th class="number">
				<g:if test="${totalParts > 0}"><g:formatNumber number="${totalActions/totalParts}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th class="number">
				<g:if test="${totalRounds > 0}"><g:formatNumber number="${totalActions/totalRounds}" type="number" maxFractionDigits="2" /></g:if>
				<g:else>0</g:else>
			</th>
			<th class="number">${totalVotes}</th>
		</tr>
       </table>
       </div>
	</section>
</body>
</html>
