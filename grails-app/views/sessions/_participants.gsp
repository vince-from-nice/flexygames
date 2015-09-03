<g:set var="now" value="${java.lang.System.currentTimeMillis()}" />
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleTableDisplay('participantsSummaryZone'); toggleTableDisplay('participantsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.participants" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<table class="fuckCSS" id="participantsSummaryZone" style="display: table; width: 100%; ">
			<tr>
				<td colspan="6" style="text-align: center; width: 100%; ">
					<g:set var="currentUserParticipation" value="${sessionInstance.getParticipationOf(session.currentUser.username)}" />
					<g:if test="${currentUserParticipation}">
						<div style="text-align: center; vertical-align: middle; border: solid black 1px; 
							background-color: ${flexygames.Participation.Status.color(currentUserParticipation.statusCode)}; ">
							<g:message code="session.show.participants.youHaveAlreadyJoined" 
								args="[message(code:'participation.status.' + currentUserParticipation.statusCode), currentUserParticipation.lastUpdater, grailsApplication.mainContext.getBean('flexygames.FlexyTagLib').formatDate(currentUserParticipation.lastUpdate.time, true)]" />
						</div>
					</g:if>
					<g:else>
						<g:message code="session.show.participants.youHaveNotJoined" />
						<g:form controller="sessions" action="join">
							<g:hiddenField name="id" value="${sessionInstance?.id}" />
							<g:actionSubmit class="create" onclick="return confirm('${message(code:'session.show.participants.join.alert')}');" 
								action="join" value="${message(code:'session.show.participants.join')}" />
						</g:form>
					</g:else>	
				</td>
			</tr>
			<g:render template="counter" model="[]" />
		</table>
		<table id="participantsDetailedZone" style="border: 0px; display: none; width: 100%">
		    <tr>
		        <td>
					<table class="flexyTab">
					    <thead>
					        <tr>
					            <th style="vertical-align: top; "><g:message code="player" /></th>
					            <th style="vertical-align: top; ">&nbsp;</th>
					            <th style="vertical-align: top; "></th>
					            <th style="vertical-align: top; min-width: 160px;"><g:message code="teams" /></th>
					            <th style="vertical-align: top; text-align: center;"><g:message code="status" /></th>
					            <th style="vertical-align: top; min-width: 250px;"><g:message code="log" /></th>
					        </tr>
					    </thead>
					    <tbody>
					    	<g:if test="${sessionInstance.participations.size() > 0}">
						        <g:each in="${sessionInstance.participations}" status="i" var="p">
						            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="border: solid grey 1px">
										<td style="vertical-align: middle; text-align: right; height: 50px; padding-left: 0px">
											<g:render template="/common/avatar" model="[player: p.player]" />
										</td>
										<td style="vertical-align: middle; padding-left: 0px; border: solid grey 0px">
											<g:link controller="player" action="show" id="${p.player.id}">
												${p.player}
											</g:link><br />
											<nobr>
											<g:if test="${p.player.getMembershipByTeam(request.defaultFirstTeam)?.feesUpToDate}">
												<span style="font-size: 10px; color: green"><g:message code="team.show.membership.feesUpToDate" /></span>
											</g:if>
											<g:else>
												<span style="font-size: 10px; color: red"><g:message code="team.show.membership.feesNotUpToDate" /></span>
											</g:else>
											</nobr>
										</td>
										<td style="vertical-align: middle; font-size: 10px; border: solid grey 0px">
											<nobr>
												<b>${p.player.countParticipations()}</b>
												<g:if test="${p.player.countParticipations() > 1}"><g:message code="participations" /></g:if>
												<g:else><g:message code="participation" /></g:else> 
											</nobr>
											<br />
											<nobr>
												<span style="color: red">
													<g:if test="${p.player.countAbsences() > 1}"><b>${p.player.countAbsences()}</b> <g:message code="absences" /><br /></g:if>
													<g:if test="${p.player.countAbsences() == 1}"><b>1</b> <g:message code="absence" /><br /></g:if>
												</span>
											</nobr>
											<nobr>
												<span style="color: #cc0">
													<g:if test="${p.player.countGateCrashes() > 1}"><b>${p.player.countGateCrashes()}</b> <g:message code="gatecrashes" /><br /></g:if>
													<g:if test="${p.player.countGateCrashes() == 1}"><b>1</b> <g:message code="gatecrash" /><br /></g:if>
												</span>
											</nobr>
											<nobr>
												<g:link controller="player" action="stats" id="${p.player.id}">
													<g:message code="detailledStats" />
												</g:link>
											</nobr>
										</td>
										<td style="vertical-align: middle; font-size: 10px; line-height: 10px; border: solid grey 1px">
											<g:each in="${p.player.teams}" var="t">
					                        	<g:link controller="teams" action="show" id="${t.id}">${t}</g:link><br />
					                    	</g:each>
					                    </td>
										<g:render template="/common/status"  model="['sessionInstance':sessionInstance, 'username':p.player.username]" />
						                <td style="vertical-align: middle; background-color: ${flexygames.Participation.Status.color(p.statusCode)}; font-size: 12px; border: solid black 1px">
						                	<g:if test="${p.lastUpdate}">
							                	<g:message code="session.show.participants.lastUpdate" args="[]" />
							                	<b><flexy:humanDate date="${p.lastUpdate.time}" /></b>
							                	<g:if test="${p.lastUpdater}">
							                		<g:message code="by" /> ${p.lastUpdater}
							                	</g:if>
							                	<g:if test="${p.userLog?.length() > 0}">: <span style="font-size: 12px"><i>${p.userLog}</i></span></g:if>
						                	</g:if>
						                </td>
						            </tr>
						        </g:each>
					        </g:if>
					        <g:else>
					        	<tr>
					        		<td colspan="6" style="text-align: center ;vertical-align: middle;">
					        			<br /><br /><br /><br /><br /><br />
					        			<g:message code="session.show.participants.empty" />
					        			<br /><br /><br /><br /><br /><br />
					        		</td>
					        	</tr>
					        </g:else>
					    </tbody>
					    <thead>
							<g:render template="counter" model="[]" />
					    </thead>
					    <tbody>
					        <tr>
								<td colspan="6" style="text-align: center">
									<g:form controller="sessions" action="join">
										<g:hiddenField name="id" value="${sessionInstance?.id}" />
										<g:actionSubmit class="create" onclick="return confirm('${message(code:'session.show.participants.join.alert')}');" 
											action="join" value="${message(code:'session.show.participants.join')}" />
									</g:form>	
								</td>
					        </tr>
						</tbody>
					</table>
		        </td>
		        <td style="width: 100px;">
					<h3><g:message code="session.show.participants.legend" /></h3>
					<table style="border: solid black 1px;">	
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.REQUESTED.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.REQUESTED}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.REQUESTED}.infos" /></span></a></td>
							<td rowspan="3" style="font-size:10px; line-height: 10px; vertical-align: middle; text-align: center; background-color: #ddeedd;">
								P<br />L<br />A<br />Y<br />E<br />R<br />S
							</td>
						</tr>
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.AVAILABLE.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.AVAILABLE}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.AVAILABLE}.infos" /></span></a></td>
						</tr>
						<tr style="border-bottom: solid black 1px">
							<td style="background-color: ${flexygames.Participation.Status.DECLINED.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.DECLINED}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.DECLINED}.infos" /></span></a></td>
						</tr>
					</table>
					<table style="border: solid black 1px;">	
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.APPROVED.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.APPROVED}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.APPROVED}.infos" /></span></a></td>
							<td rowspan="3" style="font-size:10px; line-height: 10px; vertical-align: middle; text-align: center; background-color: #ddeedd;">
								M<br />A<br />N<br />A<br />G<br />I<br />N<br />G
							</td>
						</tr>
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.WAITING_LIST.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.WAITING_LIST}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.WAITING_LIST}.infos" /></span></a></td>
						</tr>
						<tr style="border-bottom: solid black 1px">
							<td style="background-color: ${flexygames.Participation.Status.REMOVED.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.REMOVED}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.REMOVED}.infos" /></span></a></td>
						</tr>
					</table>
					<table style="border: solid black 1px;">	
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.DONE_GOOD.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.DONE_GOOD}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.DONE_GOOD}.infos" /></span></a></td>
							<td rowspan="3" style="font-size:10px; line-height: 10px; vertical-align: middle; text-align: center; background-color: #ddeedd; border-bottom: solid black 1px">
								R<br />E<br />P<br />O<br />R<br />T<br />I<br />N<br />G
							</td>
						</tr>
						<tr>
							<td style="background-color: ${flexygames.Participation.Status.DONE_BAD.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.DONE_BAD}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.DONE_BAD}.infos" /></span></a></td>
						</tr>
						<tr style="border-bottom: solid black 1px">
							<td style="background-color: ${flexygames.Participation.Status.UNDONE.color};">&nbsp;</td>
							<td><a class="tooltip"><nobr><g:message code="participation.status.${flexygames.Participation.Status.UNDONE}" /></nobr><span><g:message code="participation.status.${flexygames.Participation.Status.UNDONE}.infos" /></span></a></td>
						</tr>
					</table>
		        </td>
		    </tr>
		    <g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
				<tr>
					<td colspan="2">
						<!--h3><g:message code="management.title" /></h3-->
						<g:form controller="manager">
							<g:hiddenField name="id" value="${sessionInstance?.id}" />
							<g:hiddenField name="messageType" value="email" />
							<div class="buttons">
								<g:actionSubmit class="create" action="requestAllRegulars" value="${message(code:'management.participations.requestAllRegulars')}" />
								<g:actionSubmit class="create" action="requestAllTourists" value="${message(code:'management.participations.requestAllTourists')}" />
								<br />
								<g:actionSubmit class="create" onclick="toggleDisplay('extraInternalUserDiv'); return false" value="${message(code:'management.participations.requestInternalPlayer')}" />
								<g:actionSubmit class="create" onclick="toggleDisplay('extraExternalUserDiv'); return false" value="${message(code:'management.participations.requestExternalPlayer')}" />
								<div id="extraExternalUserDiv" style="display: none">
									<br />
									<g:select name="externalUserId" from="${flexygames.User.list(sort:'username', order:'asc')}" optionKey="id" noSelection="['':'']" />
									<g:actionSubmit class="create" action="requestExtraPlayer" value="Invite that FlexyGames user !!" /> 
								</div>
								<div id="extraInternalUserDiv" style="display: none">
									<br />
									<g:select name="internalUserId" from="${sessionInstance.group.defaultTeams.first().members}" optionKey="id"  noSelection="['':'']" />
									<g:actionSubmit class="create" action="requestExtraPlayer" value="Invite that team player !!" /> 
								</div>
								<br />
								<g:actionSubmit class="edit" onclick="toggleDisplay('customizedMessageDiv'); return false" value="${message(code:'management.participations.sendCustomizedMessage')}" />
								<g:actionSubmit class="edit" onclick="return confirm('${message(code:'management.participations.areYouSureToSendGoGoGo')}')" action="sendGoGoGoMessage" value="${message(code:'management.participations.sendGoGoGoMessage')}" />
								<br />
								<div id="customizedMessageDiv" style="display: none">
									<table style="width: auto">
										<tr>
											<%--
											<td>
												<input type="radio" name="messageType" value="email" checked>Email<br />
												<input type="radio" name="messageType" value="sms">SMS<br />
												<input type="radio" name="messageType" value="email+sms">Email + SMS<br />
											</td>
											--%>
											<td>
												<input type="radio" name="recipients" value="ONE_PARTICIPANT" checked><g:message code="management.participations.sendToSpecificParticipant" /> : 
												&nbsp;&nbsp;&nbsp;<g:select name="recipientId" from="${sessionInstance.participations*.player}" optionKey="id"/><br />
												<input type="radio" name="recipients" value="AVAILABLE_PARTICIPANTS"><g:message code="management.participations.sendToAllParticipantsAvailable" /><br />
												<input type="radio" name="recipients" value="ALL_PARTICIPANTS"><g:message code="management.participations.sendToAllParticipants" />
											</td>
											<td>
												<g:textArea name="message" rows="2" cols="40" style="width: 450px; height: 70px;">Enter a customized message here..</g:textArea><br />
											</td>
											<td style="vertical-align: middle;">
												<g:actionSubmit class="save" action="sendMessage" value="Send message !!" /> 
											</td>
										</tr>
									</table>
								</div>
								<g:actionSubmit class="save" action="approveAvailableParticipants" value="${message(code:'management.participations.approveAvailableParticipants')}" />
								<g:actionSubmit class="save" action="validateApprovedParticipants" value="${message(code:'management.participations.validateApprovedParticipants')}" />
							</div>
						</g:form>
					</td>
				</tr>
			</g:if>
		</table>
	</div>
</div>
<g:set scope="request" var="timeAfterParticipants" value="${java.lang.System.currentTimeMillis()}" />
