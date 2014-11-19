	<div class="block" style="width: auto">
		<g:set var ="totalWins" value="${playerInstance.wins.size()}" />
		<g:set var ="totalDraws" value="${playerInstance.draws.size()}" />
		<g:set var ="totalDefeats" value="${playerInstance.defeats.size()}" />
		<g:if test="${totalWins > 0 || totalDraws > 0 || totalDefeats > 0}">
			<g:message code="player.stats.gsr" /> :
			<span style="font-size: 20px; font-weight: bold;">
				<g:set var="ratio" value="${totalWins/(totalWins+totalDraws+totalDefeats)}" />
				<g:if test="${ratio == 0}">O%</g:if>
				<g:if test="${ratio == 1}">100%</g:if>
				<g:if test="${0 < ratio && ratio < 1}">${(100*ratio).toString().substring(0,2)}%</g:if>
			</span>
		</g:if>
		<g:else>
			<i><g:message code="player.stats.noParticipations" /></i>
		</g:else>
		<br />
		<span style="font-size: 14px"><g:message code="player.stats.gsr.infos" /></span>
       </div>