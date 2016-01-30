<table style="border: 0px">
	<tr>
		<td style="min-width: 400px">
			<table style="width: auto;">
				<tr>
					<td style="vertical-align: top; " ><g:message code="group" default="Group" /></td>
					<td style="vertical-align: top; " >
						<g:link controller="sessions" action="list" params="${['filteredSessionGroup':sessionInstance.group.id]}">
							${sessionInstance?.group?.encodeAsHTML()}
						</g:link>
					</td>
				</tr>
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
							<li><g:message code="session.show.date.rdv" />: <b><g:formatDate date="${sessionInstance.rdvDate}" format="HH:mm"/></b></li>
							<li><g:message code="session.show.date.start" />: <b><g:formatDate date="${sessionInstance?.date}" format="HH:mm"/></b></li>
							<li><g:message code="session.show.date.end" />: <b><g:formatDate date="${sessionInstance.endDate}" format="HH:mm"/></b></li>
						</ul>
						
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top; " ><g:message code="playground" default="Playground" /></td>
					<td style="vertical-align: top; " >
						<g:link controller="playground" action="show" id="${sessionInstance?.playground?.id}" onclick="toggleDisplay('playgroundDiv'); return false" >
							${sessionInstance?.playground?.encodeAsHTML()}
						</g:link>
						<div id="playgroundDiv" class="block" style="display: none;">
							${sessionInstance?.playground?.postalAddress}
							<g:if test="${sessionInstance?.playground?.gmapsUrl}">
								<br>
								<g:message code="phoneNumber" /> : ${sessionInstance?.playground?.phoneNumber}
							</g:if>
							<br>
							<g:link controller="playgrounds" action="show" id="${sessionInstance?.playground?.id}"><g:message code="session.show.viewPlayground" /></g:link>
						</div>
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
		<g:if test="${sessionInstance.imageUrl}">
			<td style="text-align: center; vertical-align: top;">
				<h3 style="margin-top: 0px"><g:message code="session.show.gallery" /></h3>
				<a href="${sessionInstance.imageUrl}"><img style="max-width: 200px; max-height:120px;" src="${sessionInstance.imageUrl}" alt="Image"></a><br />
				<g:if test="${sessionInstance.galleryUrl}">
					<a href="${sessionInstance.galleryUrl}"><g:message code="session.show.viewGallery" /></a>
				</g:if>
            </td>
		</g:if>
		<g:set var="forecastToken" value="${sessionInstance.playground.computeForecastToken(sessionInstance.date)}" />
		<g:if test="${forecastToken}">
			<td style="text-align: left; vertical-align: top;">
				<h3 style="margin-top: 0px"><g:message code="forecast" default="Forecast" /></h3>
				<div style="width: 70px; text-align: center">
					<g:render template="/common/forecast" model="[token: forecastToken, city: sessionInstance.playground.city]" />
				</div>
			</td>
		</g:if>
		<td style="text-align: center; vertical-align: top;">
			<g:set var="defaultFirstTeam" value="${sessionInstance.group.defaultTeams?.first()}" scope="request" />
			<h3 style="margin-top: 0px"><g:message code="session.show.relatedTeams" /></h3>
			<g:link controller="teams" action="show" id="${defaultFirstTeam.id}">
				<g:if test="${defaultFirstTeam?.logo}">
					<img style="max-width: 200px; max-height:120px;" src="${createLink(controller:'fileUploader', action:'show', id:defaultFirstTeam.logo.id)}" alt="Team logo" />
				</g:if>
				<g:else>
					<img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:'no-logo.png')}" alt="Team logo" />
				</g:else><br />
				${defaultFirstTeam}<br />
			</g:link>
		</td>
	</tr>
</table>

<g:if test="${sessionIsManagedByCurrentUser}">
    <!--h3><g:message code="management.title" /></h3-->
	<g:form controller="manager">
	    <g:hiddenField name="id" value="${sessionInstance?.id}" />
	    <div class="buttons">
            <g:actionSubmit class="edit" action="editSession" value="${message(code:'management.session.edit')}" />
            <g:actionSubmit class="create" action="duplicateSession" value="${message(code:'management.session.duplicate')}" />
            <g:actionSubmit class="delete" onclick="return confirm('${message(code:'management.session.areYouSureToDelete')}')" action="deleteSession" value="${message(code:'management.session.delete')}" />
	    </div>
	</g:form>
</g:if>

<g:set scope="request" var="timeAfterInfos" value="${java.lang.System.currentTimeMillis()}" />
