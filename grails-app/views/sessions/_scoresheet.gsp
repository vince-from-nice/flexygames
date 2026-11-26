<g:if test="${sessionInstance.date.time < System.currentTimeMillis() }">
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('scorescheetSummaryZone'); toggleDisplay('scorescheetDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.rounds" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<g:set var="defaultDisplayForSummaryZone" value="block" />
	<g:set var="defaultDisplayForDetailedZone" value="none" />
	<g:if test="${sessionInstance.rounds.size() > 0 || sessionIsManagedByCurrentUser}">
		<g:set var="defaultDisplayForSummaryZone" value="none" />
		<g:set var="defaultDisplayForDetailedZone" value="block" />
	</g:if>
	<div class="sessionZoneContent">
		<div id="scorescheetSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.rounds.size() > 0}">
				<g:message code="session.show.rounds.roundsNbr"/> : <strong>${sessionInstance.rounds.size()}</strong>
			</g:if>
			<g:else>
				<span class="muted"><g:message code="session.show.rounds.noRound"/></span>
			</g:else>
		</div>
		<div id="scorescheetDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<g:if test="${sessionInstance.rounds.size() > 0}">
				<div class="round-grid">
					<g:each in="${sessionInstance.rounds}" var="round" status="i">
						<g:set var="index" value="${i + 1}" />
						<g:set var="scoreA" value="${round.getActionsByTeam(true).size()}" />
						<g:set var="scoreB" value="${round.getActionsByTeam(false).size()}" />
						<section class="round-card">
							<h3><g:message code="round" /> #${index}</h3>
							<div class="round-teams">
								<g:each in="${[[true, 'session.show.rounds.teamA', round.playersForTeamA, scoreA, scoreB], [false, 'session.show.rounds.teamB', round.playersForTeamB, scoreB, scoreA]]}" var="team">
									<div class="round-team ${team[3] > team[4] ? 'winner' : (team[3] < team[4] ? 'loser' : '')}">
										<h4><g:message code="${team[1]}" /> <span class="round-score">${team[3]}</span></h4>
										<ul>
											<g:each in="${team[2]}" var="p">
												<li>
													<g:link controller="player" action="show" id="${p.id}">${p}</g:link>
													<g:each in="${p.getActionsBySessionRound(round)}" var="a">
														<img class="action-icon" src="${resource(dir: 'images/game', file: round.session.type.toString() + '.png')}" alt="${round.session.type}" />
													</g:each>
												</li>
											</g:each>
										</ul>
										<g:if test="${round.getUnattribuedActions(team[0]).size() > 0}">
											<p class="small muted"><g:message code="session.show.rounds.unattribuedActions" />: <strong>${round.getUnattribuedActions(team[0]).size()}</strong></p>
										</g:if>
									</div>
								</g:each>
							</div>
							<g:if test="${sessionIsManagedByCurrentUser}">
								<g:form controller="manager" class="buttons">
									<g:hiddenField name="id" value="${round.id}" />
									<input type="button" class="edit" onclick="toggleDisplay('round${index}EditDiv')" value="${message(code:'edit')}" />
									<g:actionSubmit class="create" action="duplicateRound" value="${message(code:'duplicate')}" />
									<g:actionSubmit class="delete" action="deleteRound" value="${message(code:'delete')}" />
								</g:form>
								<div id="round${index}EditDiv" class="round-edit" style="display: none">
									<g:form controller="manager">
										<g:hiddenField name="id" value="${round.id}" />
										<div class="table-wrap">
											<table class="flexyTab">
												<tr>
													<th><g:message code="player" /></th>
													<th><g:message code="session.show.rounds.edit.teamAndActions" /></th>
												</tr>
												<g:each in="${sessionInstance.effectiveParticipants}" var="p">
													<g:set var="defaultTeam" value="NotPlayed"/>
													<g:if test="${round.playersForTeamA.contains(p)}"><g:set var="defaultTeam" value="TeamA"/></g:if>
													<g:if test="${round.playersForTeamB.contains(p)}"><g:set var="defaultTeam" value="TeamB"/></g:if>
													<tr>
														<td>${p}</td>
														<td class="inline-row">
															<g:select name="player${p.id}Team" from="['NotPlayed', 'TeamA', 'TeamB']" value="${defaultTeam}" aria-label="${p}"/>
															<g:select name="player${p.id}Score" from="${0..10}" value="${round.getActionsByMainContributor(p).size()}" aria-label="${p}" />
														</td>
													</tr>
												</g:each>
												<tr>
													<th colspan="2"><g:message code="session.show.rounds.edit.unattribuedActions" /></th>
												</tr>
												<tr>
													<td><label for="unattribuedScoreForTeamA"><g:message code="session.show.rounds.teamA" /></label></td>
													<td><g:select name="unattribuedScoreForTeamA" from="${0..35}" value="${round.getUnattribuedActions(true).size()}" /></td>
												</tr>
												<tr>
													<td><label for="unattribuedScoreForTeamB"><g:message code="session.show.rounds.teamB" /></label></td>
													<td><g:select name="unattribuedScoreForTeamB" from="${0..35}" value="${round.getUnattribuedActions(false).size()}" /></td>
												</tr>
											</table>
										</div>
										<div class="buttons">
											<g:actionSubmit class="save" action="updateRound" value="${message(code:'update')}" />
										</div>
									</g:form>
								</div>
							</g:if>
						</section>
					</g:each>
				</div>
			</g:if>
			<g:else>
				<p class="muted"><g:message code="session.show.rounds.noRound"/></p>
			</g:else>
			<g:if test="${sessionIsManagedByCurrentUser}">
				<g:form controller="manager" class="buttons">
					<g:hiddenField name="id" value="${sessionInstance?.id}" />
					<g:actionSubmit class="create" action="addRound" value="${message(code:'management.rounds.addNewRound')}" />
				</g:form>
			</g:if>
		</div>
	</div>
</div>
</g:if>
<g:set scope="request" var="timeAfterScoresheet" value="${java.lang.System.currentTimeMillis()}" />
