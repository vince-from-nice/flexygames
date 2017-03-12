
<%@ page import="flexygames.CarpoolProposal" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'carpoolProposal.label', default: 'CarpoolProposal')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-carpoolProposal" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-carpoolProposal" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list carpoolProposal">
			
				<g:if test="${carpoolProposalInstance?.driver}">
				<li class="fieldcontain">
					<span id="driver-label" class="property-label"><g:message code="carpoolProposal.driver.label" default="Driver" /></span>
					
						<span class="property-value" aria-labelledby="driver-label"><g:link controller="user" action="show" id="${carpoolProposalInstance?.driver?.id}">${carpoolProposalInstance?.driver?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolProposalInstance?.approvedRequests}">
				<li class="fieldcontain">
					<span id="approvedRequests-label" class="property-label"><g:message code="carpoolProposal.approvedRequests.label" default="Approved Requests" /></span>
					
						<g:each in="${carpoolProposalInstance.approvedRequests}" var="a">
						<span class="property-value" aria-labelledby="approvedRequests-label"><g:link controller="carpoolRequest" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolProposalInstance?.carDescription}">
				<li class="fieldcontain">
					<span id="carDescription-label" class="property-label"><g:message code="carpoolProposal.carDescription.label" default="Car Description" /></span>
					
						<span class="property-value" aria-labelledby="carDescription-label"><g:fieldValue bean="${carpoolProposalInstance}" field="carDescription"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolProposalInstance?.freePlaceNbr}">
				<li class="fieldcontain">
					<span id="freePlaceNbr-label" class="property-label"><g:message code="carpoolProposal.freePlaceNbr.label" default="Free Place Nbr" /></span>
					
						<span class="property-value" aria-labelledby="freePlaceNbr-label"><g:fieldValue bean="${carpoolProposalInstance}" field="freePlaceNbr"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolProposalInstance?.rdvDescription}">
				<li class="fieldcontain">
					<span id="rdvDescription-label" class="property-label"><g:message code="carpoolProposal.rdvDescription.label" default="Rdv Description" /></span>
					
						<span class="property-value" aria-labelledby="rdvDescription-label"><g:fieldValue bean="${carpoolProposalInstance}" field="rdvDescription"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolProposalInstance?.session}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="carpoolProposal.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="session" action="show" id="${carpoolProposalInstance?.session?.id}">${carpoolProposalInstance?.session?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:carpoolProposalInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${carpoolProposalInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
