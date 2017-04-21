
<%@ page import="flexygames.CarpoolRequest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'carpoolRequest.label', default: 'CarpoolRequest')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-carpoolRequest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-carpoolRequest" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list carpoolRequest">
			
				<g:if test="${carpoolRequestInstance?.enquirer}">
				<li class="fieldcontain">
					<span id="enquirer-label" class="property-label"><g:message code="carpoolRequest.enquirer.label" default="Enquirer" /></span>
					
						<span class="property-value" aria-labelledby="enquirer-label"><g:link controller="user" action="show" id="${carpoolRequestInstance?.enquirer?.id}">${carpoolRequestInstance?.enquirer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolRequestInstance?.driver}">
				<li class="fieldcontain">
					<span id="driver-label" class="property-label"><g:message code="carpoolRequest.driver.label" default="Driver" /></span>
					
						<span class="property-value" aria-labelledby="driver-label"><g:link controller="carpoolProposal" action="show" id="${carpoolRequestInstance?.driver?.id}">${carpoolRequestInstance?.driver?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolRequestInstance?.pickupLocation}">
				<li class="fieldcontain">
					<span id="pickupLocation-label" class="property-label"><g:message code="carpoolRequest.pickupLocation.label" default="Pickup Location" /></span>
					
						<span class="property-value" aria-labelledby="pickupLocation-label"><g:fieldValue bean="${carpoolRequestInstance}" field="pickupLocation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolRequestInstance?.pickupTimeRange}">
				<li class="fieldcontain">
					<span id="pickupTimeRange-label" class="property-label"><g:message code="carpoolRequest.pickupTimeRange.label" default="Pickup Time Range" /></span>
					
						<span class="property-value" aria-labelledby="pickupTimeRange-label"><g:fieldValue bean="${carpoolRequestInstance}" field="pickupTimeRange"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolRequestInstance?.pickupTime}">
				<li class="fieldcontain">
					<span id="pickupTime-label" class="property-label"><g:message code="carpoolRequest.pickupTime.label" default="Pickup Time" /></span>
					
						<span class="property-value" aria-labelledby="pickupTime-label"><g:fieldValue bean="${carpoolRequestInstance}" field="pickupTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${carpoolRequestInstance?.session}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="carpoolRequest.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="session" action="show" id="${carpoolRequestInstance?.session?.id}">${carpoolRequestInstance?.session?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:carpoolRequestInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${carpoolRequestInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
