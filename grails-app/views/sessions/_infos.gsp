<g:if test="${sessionInstance.canceled}">
	<div class="cancel-banner">
		<strong><g:message code="management.session.canceledByOn" args="[sessionInstance.cancelationUser, sessionInstance.cancelationDate]" /></strong>
		<g:if test="${sessionInstance.cancelationLog}">
			<p>${sessionInstance.cancelationLog}</p>
		</g:if>
	</div>
</g:if>

<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('infosSummaryZone'); toggleDisplay('infosDetailedZone'); return false">
		<h2><g:message code="informations" /></h2>
		<span class="zone-hint"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<div id="infosSummaryZone" style="display: none;"></div>
		<div id="infosDetailedZone" style="display: block;">
			<div class="info-grid">
				<dl class="facts">
					<div>
						<dt><g:message code="session.show.date" /></dt>
						<dd>
							<strong class="capitalize"><g:formatDate date="${sessionInstance?.date}" format="EEEE dd MMMM yyyy" /></strong>
							<ol class="timeline">
								<li>
									<span><g:message code="session.show.date.locking" /></span>
									<strong><g:formatDate date="${sessionInstance.lockingDate}" format="HH:mm" /></strong>
									<span class="tooltip"><g:message code="session.show.date.locking.whatisit" />
										<span class="tooltiptext"><g:message code="session.show.date.locking.infos" /></span>
									</span>
								</li>
								<li><span><g:message code="session.show.date.rdv" /></span> <strong><g:formatDate date="${sessionInstance.rdvDate}" format="HH:mm" /></strong></li>
								<li><span><g:message code="session.show.date.start" /></span> <strong><g:formatDate date="${sessionInstance?.date}" format="HH:mm" /></strong></li>
								<li><span><g:message code="session.show.date.end" /></span> <strong><g:formatDate date="${sessionInstance.endDate}" format="HH:mm" /></strong></li>
							</ol>
						</dd>
					</div>
					<div>
						<dt><g:message code="playground" default="Playground" /></dt>
						<dd>
							<strong>${sessionInstance?.playground?.encodeAsHTML()}</strong><br />
							<span class="muted">${sessionInstance?.playground?.postalAddress}</span><br />
							<g:link controller="playgrounds" action="show" id="${sessionInstance?.playground?.id}"><g:message code="session.show.viewPlayground" /></g:link>
						</dd>
					</div>
					<div>
						<dt><g:message code="managers" default="Manager(s)" /></dt>
						<dd>
							<g:each in="${sessionInstance.managers}" var="manager" status="i">${i > 0 ? ', ' : ''}<g:link controller="player" action="show" id="${manager.id}">${manager.encodeAsHTML()}</g:link></g:each>
						</dd>
					</div>
					<g:if test="${sessionInstance.description}">
						<div>
							<dt><g:message code="session.description" default="Description" /></dt>
							<dd>${fieldValue(bean: sessionInstance, field: "description")}</dd>
						</div>
					</g:if>
					<g:if test="${sessionInstance.extraFieldName && sessionInstance.extraFieldValue}">
						<div>
							<dt>${sessionInstance.extraFieldName}</dt>
							<dd>
								<g:set var="shortedExtraFieldValue" value="${sessionInstance.extraFieldValue.substring(0, Math.min(sessionInstance.extraFieldValue.length(), 50))}" />
								<g:if test="${sessionInstance.extraFieldValue.startsWith('http://') || sessionInstance.extraFieldValue.startsWith('https://')}">
									<a href="${fieldValue(bean: sessionInstance, field: "extraFieldValue")}">${shortedExtraFieldValue}</a>
								</g:if>
								<g:else>${shortedExtraFieldValue}</g:else>
							</dd>
						</div>
					</g:if>
				</dl>

				<div class="team-panel">
					<g:set var="defaultFirstTeam" value="${sessionInstance.group.defaultTeams?.first()}" scope="request" />
					<h3><g:message code="session.show.relatedTeams" /></h3>
					<g:link controller="teams" action="show" id="${defaultFirstTeam.id}">
						<flexy:teamLogo team="${defaultFirstTeam}" size="large" />
					</g:link>
					<g:set var="mode" value="${sessionInstance.group.competition ? 'competition' : 'training'}" />
					<p>
						<g:message code="group" default="Group" />:
						<g:link controller="teams" action="show" id="${sessionInstance.group.defaultTeams?.first().id}" params="${['mode': mode, 'group': sessionInstance.group.id]}">${sessionInstance?.group?.encodeAsHTML()}</g:link>
					</p>
				</div>

				<div class="forecast-panel">
					<h3><g:message code="forecast" default="Forecast" /></h3>
					<g:render template="forecast" />
				</div>

				<g:if test="${sessionInstance.imageUrl}">
					<div class="team-panel">
						<h3><g:message code="session.show.gallery" /></h3>
						<a href="${sessionInstance.imageUrl}"><img class="gallery-image" src="${sessionInstance.imageUrl}" alt="Image" /></a>
						<g:if test="${sessionInstance.galleryUrl}">
							<p><a href="${sessionInstance.galleryUrl}"><g:message code="session.show.viewGallery" /></a></p>
						</g:if>
					</div>
				</g:if>
			</div>

			<g:if test="${sessionIsManagedByCurrentUser}">
				<g:form controller="manager" class="manager-actions">
					<g:hiddenField name="id" value="${sessionInstance?.id}" />
					<div class="buttons">
						<g:actionSubmit class="edit" action="editSession" value="${message(code: 'management.session.edit')}" />
						<g:actionSubmit class="create" action="duplicateSession" value="${message(code: 'management.session.duplicate')}" onclick="toggleDisplay('duplicationForm'); return false; " />
						<g:if test="${!sessionInstance.canceled}">
							<g:actionSubmit class="delete" action="deleteSession" value="${message(code: 'management.session.cancel')}" onclick="toggleDisplay('cancelationForm'); return false; " />
						</g:if>
					</div>
					<div id="duplicationForm" class="inline-form" style="display: none;">
						<label for="duplicationOffset"><g:message code="management.session.duplicationOffset" /></label>
						<g:field type="number" name="duplicationOffset" value="7" style="width: 5em;" />
						<g:actionSubmit class="create" value="Ok" action="duplicateSession" />
					</div>
					<div id="cancelationForm" class="inline-form" style="display: none;">
						<label for="cancelationLog"><g:message code="management.session.cancelInfos" /></label>
						<g:textArea name="cancelationLog" rows="3"></g:textArea>
						<g:actionSubmit class="delete" value="Ok" action="cancelSession" />
					</div>
				</g:form>
			</g:if>
		</div>
	</div>
</div>

<g:set scope="request" var="timeAfterInfos" value="${java.lang.System.currentTimeMillis()}" />
