			<%def totalWins =0, totalDraws=0, totalDefeats=0, totalActionScore=0, totalVotingScore=0; %>
			<g:each in="${userParticipations}" var="part">
				<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: part.session.id, absolute: true)}" />
				<tr class="clickable" onclick="document.location='${sessionLink}'">
					<td>
						<g:link controller="sessions" action="show" id="${part.session.id}"><g:formatDate date="${part.session.date}" format="yyyy-MM-dd" /></g:link>
					</td>
					<td class="team-cell">
						<g:set var="team" value="${part.session.group.defaultTeams.first()}" />
						<g:link controller="teams" action="show" id="${team.id}" title="${team}"><flexy:teamLogo team="${team}" /></g:link>
					</td>
					<td class="small">
						<g:link controller="sessions" action="list" params="${['filteredSessionGroup':part.session.group.id]}">${part.session.group.encodeAsHTML()}</g:link>
					</td>
					<td class="status-cell">
						<span class="status-pill" style="background-color: ${flexygames.Participation.Status.color(part.statusCode)};"><g:message code="participation.status.${part.statusCode}" /></span>
					</td>
					<g:if test="${withAllCols}">
						<td class="number">
							<g:set var="v" value="${part.wins.size()}" />
							<g:if test="${v > 0}"><%totalWins += v%><span class="score-plus">${v}</span></g:if>
						</td>
						<td class="number">
							<g:set var="v" value="${part.draws.size()}" />
							<g:if test="${v > 0}"><%totalDraws += v%>${v}</g:if>
						</td>
						<td class="number">
							<g:set var="v" value="${part.defeats.size()}" />
							<g:if test="${v > 0}"><%totalDefeats += v%><span class="score-minus">${v}</span></g:if>
						</td>
						<td class="number">
							<g:set var="v" value="${part.actionScore}" />
							<%totalActionScore += v%>
							<g:if test="${v > 0}">${v}</g:if>
						</td>
						<td class="number">
							<g:set var="v" value="${part.votingScore}" />
							<%totalVotingScore += v%>
							<g:if test="${v > 0}"><span class="score-plus">+${v}</span></g:if>
							<g:elseif test="${v < 0}"><span class="score-minus">${v}</span></g:elseif>
							<g:else>${v}</g:else>
						</td>
					</g:if>
				</tr>
			</g:each>
			<g:if test="${withTotals}">
				<tr class="counter-row">
					<th colspan="4"></th>
					<th class="number"><span class="score-plus">${totalWins}</span></th>
					<th class="number">${totalDraws}</th>
					<th class="number"><span class="score-minus">${totalDefeats}</span></th>
					<th class="number">${totalActionScore}</th>
					<th class="number">
						<g:if test="${totalVotingScore > 0}"><span class="score-plus">+${totalVotingScore}</span></g:if>
						<g:elseif test="${totalVotingScore < 0}"><span class="score-minus">${totalVotingScore}</span></g:elseif>
						<g:else>${totalVotingScore}</g:else>
					</th>
				</tr>
			</g:if>
