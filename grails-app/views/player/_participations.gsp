			<%def totalWins =0, totalDraws=0, totalDefeats=0, totalActionScore=0, totalVotingScore=0; %>
			<g:each in="${userParticipations}" var="part">
				<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: part.session.id, absolute: true)}" />
				<tr style="height: 60px; margin: 0px; padding: 0px; border: solid grey 1px; cursor: pointer;" onclick="document.location='${sessionLink}'">
					<td style="vertical-align: middle;">
						<g:link controller="sessions" action="show" id="${part.session.id}">
							<nobr><g:formatDate date="${part.session.date}" format="yyyy-MM-dd" timeStyle="LONG" /></nobr>
						</g:link>
					</td>
					<td style="vertical-align: middle;">
						<g:set var="team" value="${part.session.group.defaultTeams.first()}" />
						<g:link controller="teams" action="show" id="${team.id}">
							<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
						</g:link>
					</td>
					<td style="vertical-align: middle; font-size: 12px">
						<g:link controller="sessions" action="list" params="${['filteredSessionGroup':part.session.group.id]}">
							<nobr>${part.session.group.encodeAsHTML()}</nobr>
						</g:link>
					</td>
					<td style="vertical-align: middle; border-left: solid black 1px; background-color: ${flexygames.Participation.Status.color(part.statusCode)}">
						<b><g:message code="participation.status.${part.statusCode}" /></b>
					</td>
					<td style="text-align: right; vertical-align: middle; border-left: solid black 1px">
						<g:set var="v" value="${part.wins.size()}" />
						<g:if test="${v > 0}"><%totalWins += v%><span style="color: green">${v}</span></g:if>
					</td>
					<td style="text-align: right; vertical-align: middle;">
						<g:set var="v" value="${part.draws.size()}" />
						<g:if test="${v > 0}"><%totalDraws += v%>${v}</g:if>
					</td>
					<td style="text-align: right; vertical-align: middle;">
						<g:set var="v" value="${part.defeats.size()}" />
						<g:if test="${v > 0}"><%totalDefeats += v%><span style="color: red">${v}</span></g:if>
					</td>
					<td style="text-align: right; vertical-align: middle; border-left: solid black 1px">
						<g:set var="v" value="${part.actionScore}" />
						<%totalActionScore += v%>
						<g:if test="${v > 0}">${v}</g:if>
					</td>
					<td style="text-align: right; vertical-align: middle; border-left: solid black 1px">
						<g:set var="v" value="${part.votingScore}" />
						<%totalVotingScore += v%>
						<g:if test="${v > 0}"><span style="color: green">+${v}</span></g:if>
						<g:else>
							<g:if test="${v < 0}"><span style="color: red">${v}</span></g:if>
							<g:else><span style="color: black">${v}</span></g:else>
						</g:else>
					</td>
				</tr>
			</g:each>
			<g:if test="${withTotals}">
				<tr>
					<th style="font-size: 18px; font-weight: bold; text-align: left; vertical-align: middle;" colspan="2">
						<g:message code="player.show.totalOfParticipations"/>
					</th>
					<th style="font-size: 18px; text-align: center; vertical-align: middle;">${playerInstance.effectiveParticipations.size()}</th>
					<th style="font-size: 18px; text-align: right; vertical-align: middle;"><span style="color: green">${totalWins}</span></th>
					<th style="font-size: 18px; text-align: right; vertical-align: middle;">${totalDraws}</th>
					<th style="font-size: 18px; text-align: right; vertical-align: middle;"><span style="color: red">${totalDefeats}</span></th>
					<th style="font-size: 18px; text-align: right; vertical-align: middle;">${totalActionScore}</th>
					<th style="font-size: 18px; text-align: right; vertical-align: middle;">
						<g:if test="${totalVotingScore > 0}"><span style="color: green">+${totalVotingScore}</span></g:if>
						<g:else>
							<g:if test="${totalVotingScore < 0}"><span style="color: red">${totalVotingScore}</span></g:if>
							<g:else>${totalVotingScore}</g:else>
						</g:else>
					</th>
				</tr>
			</g:if>