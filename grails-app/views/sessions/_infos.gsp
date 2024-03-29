<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('infosSummaryZone'); toggleDisplay('infosDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="informations" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:set var="defaultDisplayForSummaryZone" value="none" />
		<g:set var="defaultDisplayForDetailedZone" value="block" />
		<div id="infosSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
		</div>
		<div id="infosDetailedZone" style="display: ${defaultDisplayForDetailedZone}; border: 0px; width: 100%;">
			<table style="border: 0px; width: 100%; margin-bottom: 0px;">
				<tr>
					<td style="min-width: 400px; width: 40%">
						<table style="width: auto;">
							<g:if test="${sessionInstance.description}">
								<tr >
									<td style="vertical-align: top; ">
										<g:message code="session.description" default="Description" />
									</td>
									<td style="vertical-align: top; ">
										${fieldValue(bean: sessionInstance, field: "description")}
									</td>
								</tr>
							</g:if>
							<g:if test="${sessionInstance.extraFieldName && sessionInstance.extraFieldValue}">
								<tr >
									<td style="vertical-align: top; ">
										${sessionInstance.extraFieldName}
									</td>
									<td style="vertical-align: top; ">
										<g:set var="shortedExtraFieldValue" value="${sessionInstance.extraFieldValue.substring(0, Math.min(sessionInstance.extraFieldValue.length(), 50))}"/>
										<g:if test="${sessionInstance.extraFieldValue.startsWith('http://') || sessionInstance.extraFieldValue.startsWith('https://')}">
											<a href="${fieldValue(bean: sessionInstance, field: "extraFieldValue")}">${shortedExtraFieldValue}</a>
										</g:if>
										<g:else>
											${shortedExtraFieldValue}
										</g:else>
									</td>
								</tr>
							</g:if>
							<tr>
								<td style="vertical-align: top; " ><g:message code="session.show.date"/></td>
								<td style="vertical-align: top; " >
									<b><g:formatDate date="${sessionInstance?.date}" format="EEEE dd MMMM yyyy"/></b>
									<ul>
										<li>
											<g:message code="session.show.date.locking" />: <b><g:formatDate date="${sessionInstance.lockingDate}" format="HH:mm"/></b>
											<div style="font-size: x-small; color: red" class="tooltip">
												<g:message code="session.show.date.locking.whatisit"/>
												<span class="tooltiptext"><g:message code="session.show.date.locking.infos"/></span>
											</div>
										</li>
										<li><g:message code="session.show.date.rdv" />: <b><g:formatDate date="${sessionInstance.rdvDate}" format="HH:mm"/></b></li>
										<li><g:message code="session.show.date.start" />: <b><g:formatDate date="${sessionInstance?.date}" format="HH:mm"/></b></li>
										<li><g:message code="session.show.date.end" />: <b><g:formatDate date="${sessionInstance.endDate}" format="HH:mm"/></b></li>
									</ul>

								</td>
							</tr>
							<tr>
								<td style="vertical-align: top; " ><g:message code="playground" default="Playground" /></td>
								<td style="vertical-align: top; " >
									<b>${sessionInstance?.playground?.encodeAsHTML()}</b>
									<br>
									${sessionInstance?.playground?.postalAddress}
									<br>
									<g:link controller="playgrounds" action="show" id="${sessionInstance?.playground?.id}"><g:message code="session.show.viewPlayground" /></g:link>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: top; " ><g:message code="managers" default="Manager(s)" /></td>
								<td style="vertical-align: top; " >
									<g:each in="${sessionInstance.managers}" var="manager">
										<g:link controller="player" action="show" id="${manager.id}">
											${manager.encodeAsHTML()}
										</g:link>
									</g:each>
								</td>
							</tr>
						</table>
					</td>
					<td style="text-align: center; vertical-align: top;">
						<g:set var="defaultFirstTeam" value="${sessionInstance.group.defaultTeams?.first()}" scope="request" />
						<h3 style="margin-top: 0px"><g:message code="session.show.relatedTeams" /></h3>
						<g:link controller="teams" action="show" id="${defaultFirstTeam.id}">
							<g:if test="${defaultFirstTeam?.logoName}">
								<img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:defaultFirstTeam.logoName)}" alt="Team logo" />
							</g:if>
							<g:else>
								<img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:'no-logo.png')}" alt="Team logo" />
							</g:else><br />
							<!--${defaultFirstTeam}-->
						</g:link>
						<br />
						<br />
						<g:message code="group" default="Group" />:
						<g:set var="mode" value="training" />
						<g:if test="${sessionInstance.group.competition}">
							<g:set var="mode" value="competition" />
						</g:if>
						<g:link controller="teams" action="show" id="${sessionInstance.group.defaultTeams?.first().id}" params="${['mode':mode, 'group':sessionInstance.group.id]}">
							${sessionInstance?.group?.encodeAsHTML()}
						</g:link>
					</td>
					<td style="text-align: left; vertical-align: top;">
						<h3 style="margin-top: 0px"><g:message code="forecast" default="Forecast" /></h3>
						<div style="text-align: left">
							<!--iframe src="${createLink(controller: 'sessions', action: 'forecast', id: sessionInstance.id)}" id="forecastFrame" style="border: 0px;" ></iframe-->
							<!--div id="forecastDiv"></div>
							<script style="javascript">
								$.get( "${createLink(controller: 'sessions', action: 'forecast', id: sessionInstance.id)}", function( data ) {
									$("#forecastDiv").html(data)
								});
							</script-->
							<g:render template="forecast" />
						</div>
					</td>
					<g:if test="${sessionInstance.imageUrl}">
						<td style="text-align: center; vertical-align: top;">
							<h3 style="margin-top: 0px"><g:message code="session.show.gallery" /></h3>
							<a href="${sessionInstance.imageUrl}"><img style="max-width: 200px; max-height:120px;" src="${sessionInstance.imageUrl}" alt="Image"></a><br />
							<g:if test="${sessionInstance.galleryUrl}">
								<a href="${sessionInstance.galleryUrl}"><g:message code="session.show.viewGallery" /></a>
							</g:if>
						</td>
					</g:if>
				</tr>
			</table>
			<g:if test="${sessionIsManagedByCurrentUser}">
				<span style="width: 100%	">
					<g:form controller="manager">
						<g:hiddenField name="id" value="${sessionInstance?.id}" />
						<div class="buttons">
							<g:actionSubmit class="edit" action="editSession" value="${message(code:'management.session.edit')}" />
							<g:actionSubmit class="create" action="duplicateSession" value="${message(code:'management.session.duplicate')}" onclick="toggleDisplay('duplicationForm'); return false; " />
							<g:if test="${!sessionInstance.canceled}">
								<g:actionSubmit class="delete" action="deleteSession" value="${message(code:'management.session.cancel')}" onclick="toggleDisplay('cancelationForm'); return false; " />
								<!--span style="color: red;"><= NEW !!</span-->
							</g:if>
						</div>
						<div id="duplicationForm" style="display: none; ">
							<br>
							<g:message code="management.session.duplicationOffset" />:
							<g:field type="number" name="duplicationOffset" value="7" size="2" style="width: 3em;" />
							<g:actionSubmit class="create" value="Ok" action="duplicateSession" />
						</div>
						<div id="cancelationForm" style="display: none; ">
							<br>
							<g:message code="management.session.cancelInfos" />:
							<br>
							<g:textArea name="cancelationLog" style="width: 80%;"></g:textArea>
							<g:actionSubmit class="delete" value="Ok" action="cancelSession" />
						</div>
					</g:form>
				</span>
			</g:if>
		</div>
	</div>
</div>

<g:if test="${sessionInstance.canceled}">
	<br>
	<div style="background-color: #dbb7ac; border: 2px solid red; text-align: center; font-size: xx-large">
		<span style="color: red"><g:message code="management.session.canceledByOn" args="[sessionInstance.cancelationUser, sessionInstance.cancelationDate]" /></span>
		<br>
		<i>${sessionInstance.cancelationLog}</i>
	</div>
</g:if>


<g:set scope="request" var="timeAfterInfos" value="${java.lang.System.currentTimeMillis()}" />
