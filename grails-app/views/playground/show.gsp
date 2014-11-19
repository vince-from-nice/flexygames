
<%@ page import="flexygames.Playground" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playground.label', default: 'Playground')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-playground" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-playground" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list playground">
			
				<g:if test="${playgroundInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="playground.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${playgroundInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="playground.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${playgroundInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.street}">
				<li class="fieldcontain">
					<span id="street-label" class="property-label"><g:message code="playground.street.label" default="Street" /></span>
					
						<span class="property-value" aria-labelledby="street-label"><g:fieldValue bean="${playgroundInstance}" field="street"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.zip}">
				<li class="fieldcontain">
					<span id="zip-label" class="property-label"><g:message code="playground.zip.label" default="Zip" /></span>
					
						<span class="property-value" aria-labelledby="zip-label"><g:fieldValue bean="${playgroundInstance}" field="zip"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="playground.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${playgroundInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.country}">
				<li class="fieldcontain">
					<span id="country-label" class="property-label"><g:message code="playground.country.label" default="Country" /></span>
					
						<span class="property-value" aria-labelledby="country-label"><g:fieldValue bean="${playgroundInstance}" field="country"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="playground.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${playgroundInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="playground.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${playgroundInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.phoneNumber}">
				<li class="fieldcontain">
					<span id="phoneNumber-label" class="property-label"><g:message code="playground.phoneNumber.label" default="Phone Number" /></span>
					
						<span class="property-value" aria-labelledby="phoneNumber-label"><g:fieldValue bean="${playgroundInstance}" field="phoneNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.websiteUrl}">
				<li class="fieldcontain">
					<span id="websiteUrl-label" class="property-label"><g:message code="playground.websiteUrl.label" default="Website Url" /></span>
					
						<span class="property-value" aria-labelledby="websiteUrl-label"><g:fieldValue bean="${playgroundInstance}" field="websiteUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.gmapsUrl}">
				<li class="fieldcontain">
					<span id="gmapsUrl-label" class="property-label"><g:message code="playground.gmapsUrl.label" default="Gmaps Url" /></span>
					
						<span class="property-value" aria-labelledby="gmapsUrl-label"><g:fieldValue bean="${playgroundInstance}" field="gmapsUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.flexymapUrl}">
				<li class="fieldcontain">
					<span id="flexymapUrl-label" class="property-label"><g:message code="playground.flexymapUrl.label" default="Flexymap Url" /></span>
					
						<span class="property-value" aria-labelledby="flexymapUrl-label"><g:fieldValue bean="${playgroundInstance}" field="flexymapUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.forecastType}">
				<li class="fieldcontain">
					<span id="forecastType-label" class="property-label"><g:message code="playground.forecastType.label" default="Forecast Type" /></span>
					
						<span class="property-value" aria-labelledby="forecastType-label"><g:fieldValue bean="${playgroundInstance}" field="forecastType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.forecastToken}">
				<li class="fieldcontain">
					<span id="forecastToken-label" class="property-label"><g:message code="playground.forecastToken.label" default="Forecast Token" /></span>
					
						<span class="property-value" aria-labelledby="forecastToken-label"><g:fieldValue bean="${playgroundInstance}" field="forecastToken"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.sessionGroups}">
				<li class="fieldcontain">
					<span id="sessionGroups-label" class="property-label"><g:message code="playground.sessionGroups.label" default="Session Groups" /></span>
					
						<g:each in="${playgroundInstance.sessionGroups}" var="s">
						<span class="property-value" aria-labelledby="sessionGroups-label"><g:link controller="sessionGroup" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${playgroundInstance?.sessions}">
				<li class="fieldcontain">
					<span id="sessions-label" class="property-label"><g:message code="playground.sessions.label" default="Sessions" /></span>
					
						<g:each in="${playgroundInstance.sessions}" var="s">
						<span class="property-value" aria-labelledby="sessions-label"><g:link controller="session" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${playgroundInstance?.id}" />
					<g:link class="edit" action="edit" id="${playgroundInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
