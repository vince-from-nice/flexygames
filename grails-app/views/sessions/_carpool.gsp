<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('carpoolSummaryZone'); toggleDisplay('carpoolDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.carpool" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.comments.size() > 0}">
			<g:set var="defaultDisplayForSummaryZone" value="none" />
			<g:set var="defaultDisplayForDetailedZone" value="block" />
		</g:if>
		<div id="carpoolSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<table style="width: 100%; border: 0px; margin: 0px;" >
				<tr>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolProposals.size() > 0}" >
							<g:message code="session.show.carpool.carpoolProposalsNbr" args="[sessionInstance.carpoolProposals.size()]"/>:
							<g:each in="${sessionInstance.carpoolProposals}" var="proposal">
								<g:link controller="players">
									${proposal.driver.username}
								</g:link>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolProposal"/>
						</g:else>
					</td>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolRequests.size() > 0}" >
							<g:message code="session.show.carpool.carpoolRequestsNbr" args="[sessionInstance.carpoolRequests.size()]"/>:
							<g:each in="${sessionInstance.carpoolRequests}" var="request">
								<g:link controller="players">
									${request.enquirer.username}
								</g:link>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolRequest"/>
						</g:else>
					</td>
				</tr>
			</table>
		</div>
		<div id="carpoolDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<table style="width: 100%; border: 0px; margin: 0px;" >
				<tr>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolProposals.size() > 0}" >
							<g:message code="session.show.carpool.carpoolProposalsNbr" args="[sessionInstance.carpoolProposals.size()]"/> :
							<br>
							<br>
							<g:each in="${sessionInstance.carpoolProposals}" var="proposal">
								<div style="border: solid lightblue 1px; padding: 10px;">
									<g:render template="/common/avatar" model="[player:proposal.driver]" />
									<g:message code="session.show.carpool.proposal.userXCanTakeY" args="[proposal.driver.username, proposal.freePlaceNbr]"/>:
									<g:each in="${(1..proposal.freePlaceNbr).toList()}" var="i">
										<div id="seat${i}For${proposal.driver.username}"
											 style="border: lightskyblue dashed 1px; width: 50px; height: 50px; display: inline-block; text-align: center;">
											<g:message code="session.show.carpool.proposal.seatNbr" args="[i]"/>
											<br>
										</div>&nbsp;
									</g:each>
									<g:if test="${proposal.rdvDescription}">
										<br>
										<g:message code="session.show.carpool.proposal.rdvDescription"/>:
										<b>${proposal.rdvDescription}</b>
									</g:if>
									<g:if test="${proposal.carDescription}">
										<br>
										<g:message code="session.show.carpool.proposal.carDescription"/>:
										<b>${proposal.carDescription}</b>
									</g:if>
								</div>
								<g:if test="${sessionIsManagedByCurrentUser || proposal.driver == session.currentUser}">
									<g:form>
										<g:hiddenField name="id" value="${proposal.id}" />
										<div class="buttons">
											<g:actionSubmit class="delete"  action="removeCarpoolProposal" value="${message(code:'delete')}" />
										</div>
									</g:form>
								</g:if>
								<br>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolProposal"/>
						</g:else>
					</td>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolRequests.size() > 0}" >
							<g:message code="session.show.carpool.carpoolRequestsNbr" args="[sessionInstance.carpoolRequests.size()]"/> :
							<br>
							<br>
							<g:each in="${sessionInstance.carpoolRequests}" var="request">
								<div style="border: solid lightsalmon 1px; padding: 5px; display: inline-block;">
									<g:render template="/common/avatar" model="[player:request.enquirer]" />
									<g:if test="${sessionIsManagedByCurrentUser || request.enquirer == session.currentUser}">
										<g:link action="removeCarpoolRequest" id="${request.id}" >
											<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
										</g:link>
									</g:if>
									<br>
									<g:link controller="player" action="show" id="${request.enquirer.id}">${request.enquirer.username}</g:link>
								</div>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolRequest"/>
						</g:else>
					</td>
				</tr>
				<tr>
					<td>
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.proposal.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
							<div style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightblue; text-align: center; padding: 10px">
								<b><g:message code="session.show.carpool.proposal.title" /></b>
								<br>
								<br>
								<g:form action="proposeCarpool">
									<g:hiddenField name="id" value="${sessionInstance.id}" />
									<g:message code="session.show.carpool.proposal.freePlaces.prefix" />
									<g:field name="freePlaceNbr" type="number" value="3" required="" size="2" style="width: 2em;" />
									<g:message code="session.show.carpool.proposal.freePlaces.suffix" />
									<br>
									<g:message code="session.show.carpool.proposal.carDescription" />
									<g:field name="carDescription" value="Lada vert bouteille" required=""/>
									<br>
									<g:message code="session.show.carpool.proposal.rdvDescription" />
									<g:field name="rdvDescription" value="Parking du LIDL à 23h" required="" size="30"/>
									<br>
									<br>
									<g:actionSubmit class="save" action="addCarpoolProposal" value="${message(code:'session.show.carpool.proposal.validate')}"/>
								</g:form>
							</div>
						</shiro:user>
					</td>
					<td>
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.request.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
							<div style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightsalmon; text-align: center; padding: 10px">
								<b><g:message code="session.show.carpool.request.title" /></b>
								<br>
								<g:form action="proposeCarpool">
									<g:hiddenField name="id" value="${sessionInstance.id}" />
									<br>
									<g:actionSubmit class="save" action="addCarpoolRequest" value="${message(code:'session.show.carpool.request.validate')}" />
								</g:form>
							</div>
						</shiro:user>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
