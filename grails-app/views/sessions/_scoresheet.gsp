<g:if test="${sessionInstance.date.time < System.currentTimeMillis() }">
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('scorescheetSummaryZone'); toggleTableDisplay('scorescheetDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.rounds" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<g:set var="defaultDisplayForSummaryZone" value="block" />
	<g:set var="defaultDisplayForDetailedZone" value="none" />
	<g:if test="${sessionInstance.votes.size() > 0}">
		<g:set var="defaultDisplayForSummaryZone" value="none" />
		<g:set var="defaultDisplayForDetailedZone" value="table" />
	</g:if>
	<div class="sessionZoneContent">
		<div id="scorescheetSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.rounds.size() > 0}" >
				<g:message code="session.show.rounds.roundsNbr"/> : <b>${sessionInstance.rounds.size()}</b>
			</g:if>
			<g:else>
				<g:message code="session.show.rounds.noRound"/>
			</g:else>
		</div>
		<table id="scorescheetDetailedZone" style="display: ${defaultDisplayForDetailedZone}; border: none; margin: 0px">
			<tr>
				<g:set var="index" value="${0}" />
				<g:if test="${sessionInstance.rounds.size() > 0}" >
					<g:each in="${sessionInstance.rounds}" var="round">
						<g:set var="index" value="${index + 1}" />
						<g:set var="actionsNbrForTeamA" value="${round.getActionsByTeam(true).size()}" />
						<g:set var="actionsNbrForTeamB" value="${round.getActionsByTeam(false).size()}" />
						<td style="text-align: center">
							<h3><g:message code="round" /> #${index}</h3>
							<table>
								<tr>
									<th><g:message code="session.show.rounds.teamA" /></th>
									<th><g:message code="session.show.rounds.teamB" /></th>
								</tr>
								<tr>
									<td>
										<ul>
											<g:each in="${round.playersForTeamA}" var="p">
												<li>
													<nobr>
													<g:link controller="player" action="show" id="${p.id}">${p}</g:link>&nbsp;&nbsp;&nbsp; 
													<g:each in="${p.getActionsBySessionRound(round)}" var="a">
														<img style="height: 12px" src='<g:resource dir="images/game" file="${round.session.type}.png" />' alt="${round.session} action logo">
													</g:each>
													</nobr>
												</li>
											</g:each>
										</ul></td>
									<td>
										<ul>
											<g:each in="${round.playersForTeamB}" var="p">
												<li>
													<nobr>
													<g:link controller="player" action="show" id="${p.id}">${p}</g:link>&nbsp;&nbsp;&nbsp; 
													<g:each in="${p.getActionsBySessionRound(round)}" var="a">
														<img style="height: 12px" src='<g:resource dir="images/game" file="${round.session.type}.png" />' alt="${round.session} action logo">
													</g:each>
													</nobr>
												</li>
											</g:each>
										</ul></td>
								</tr>
								<g:if test="${round.getUnattribuedActions(true).size() > 0 || round.getUnattribuedActions(false).size() > 0}">
									<tr>
										<td>
											<g:message code="session.show.rounds.unattribuedActions" />: <b>${round.getUnattribuedActions(true).size()}</b>
										</td>
										<td>
											<g:message code="session.show.rounds.unattribuedActions" />: <b>${round.getUnattribuedActions(false).size()}</b>
										</td>
									</tr>
								</g:if>
								<g:if test="${actionsNbrForTeamA > actionsNbrForTeamB}">
									<tr>
										<th><div style="color: green"><g:message code="Total" />: ${actionsNbrForTeamA}</div>
										</th>
										<th><div style="color: red"><g:message code="Total" />: ${actionsNbrForTeamB}</div>
										</th>
									</tr>
								</g:if>
								<g:if test="${actionsNbrForTeamA < actionsNbrForTeamB}">
									<tr>
										<th><div style="color: red"><g:message code="Total" />: ${actionsNbrForTeamA}</div>
										</th>
										<th><div style="color: green"><g:message code="Total" />: ${actionsNbrForTeamB}</div>
										</th>
									</tr>
								</g:if>
								<g:if test="${actionsNbrForTeamA == actionsNbrForTeamB}">
									<tr>
										<th><div style="color: black"><g:message code="Total" />: ${actionsNbrForTeamA}</div>
										</th>
										<th><div style="color: black"><g:message code="Total" />: ${actionsNbrForTeamB}</div>
										</th>
									</tr>
								</g:if>
								<g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
									<tr>
										<td colspan="2">
										    <g:form controller="manager">
										        <g:hiddenField name="id" value="${round.id}" />
										        <div class="buttons">
										            <input type="button" class="edit" onclick="toggleDisplay('round${index}EditDiv')" value="${message(code:'edit')}" />
										            <g:actionSubmit class="create"  action="duplicateRound" value="${message(code:'duplicate')}" />
										            <g:actionSubmit class="delete"  action="deleteRound" value="${message(code:'delete')}" />
										        </div>
										    </g:form>
										    <div id="round${index}EditDiv" style="display: none">
								            <br />
								            <g:hiddenField name="id" value="${round.id}" />
								            	<g:form controller="manager">
								            		<g:hiddenField name="id" value="${round.id}" />
								            		<table>
								            			<tr>
								            				<th><g:message code="player" /></th>
								            				<th><g:message code="session.show.rounds.edit.teamAndActions" /></th>
								            			</tr>
								            			<g:each in="${sessionInstance.effectiveParticipants}" var="p">
									            			<tr>
									            				<td>
									            					${p}
									            				</td>
									            				<td>
									            					<g:set var="defaultTeam" value="NotPlayed"/>
									            					<g:if test="${round.playersForTeamA.contains(p)}"><g:set var="defaultTeam" value="TeamA"/></g:if>
									            					<g:if test="${round.playersForTeamB.contains(p)}"><g:set var="defaultTeam" value="TeamB"/></g:if>
									            					<g:select name="player${p.id}Team" from="['NotPlayed', 'TeamA', 'TeamB']" value="${defaultTeam}"/>
									            					<g:select name="player${p.id}Score" from="${0..10}" value="${round.getActionsByMainContributor(p).size()}" />
									            				</td>
									            			</tr>
								            			</g:each>
								            			<tr>
								            				<th colspan="2"><g:message code="session.show.rounds.edit.unattribuedActions" /></th>
								            			</tr>
														<tr>
															<td><g:message code="session.show.rounds.teamA" /></td>
															<td><g:select name="unattribuedScoreForTeamA" from="${0..35}" value="${round.getUnattribuedActions(true).size()}" /></td>
														</tr>
														<tr>
															<td><g:message code="session.show.rounds.teamB" /></td>
															<td><g:select name="unattribuedScoreForTeamB" from="${0..35}" value="${round.getUnattribuedActions(false).size()}" /></td>
														</tr>
								            		</table>
									        		<div class="buttons">
														<g:actionSubmit class="edit" action="updateRound" value="${message(code:'update')}" />
													</div>
												</g:form>
											</div>
										</td>
									</tr>
								</g:if>
							</table>
						</td>
					</g:each>
				</g:if>
				<g:else>
					<td style="text-align: center">
						<br />
						<i><g:message code="session.show.rounds.noRound"/></i>
						<br />
					</td>
				</g:else>
			</tr>
			<g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
				<tr>
					<td>
					    <g:if test="${sessionInstance.date.time > System.currentTimeMillis() }">
							<h2><g:message code="session.show.rounds" /></h2>
						</g:if>
					    <g:form controller="manager">
					        <g:hiddenField name="id" value="${sessionInstance?.id}" />
					        <div class="buttons">
								<g:actionSubmit class="create"  action="addRound" value="${message(code:'management.rounds.addNewRound')}" />
					        </div>
					    </g:form>
			    	</td>
			    </tr>
			</g:if>
		</table>
	</div>
</div>
</g:if>
<g:set scope="request" var="timeAfterScoresheet" value="${java.lang.System.currentTimeMillis()}" />
