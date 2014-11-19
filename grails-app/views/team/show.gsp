
<%@ page import="flexygames.Team" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-team" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-team" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
				<div class="errors">${flash.error}</div>
			</g:if>
			<ol class="property-list team">
			
				<g:if test="${teamInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="team.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${teamInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="team.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${teamInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="team.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${teamInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.webUrl}">
				<li class="fieldcontain">
					<span id="webUrl-label" class="property-label"><g:message code="team.webUrl.label" default="Web Url" /></span>
					
						<span class="property-value" aria-labelledby="webUrl-label"><g:fieldValue bean="${teamInstance}" field="webUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="team.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${teamInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.logo}">
				<li class="fieldcontain">
					<span id="logo-label" class="property-label"><g:message code="team.logo.label" default="Logo" /></span>
					
						<span class="property-value" aria-labelledby="logo-label"><g:link controller="UFile" action="show" id="${teamInstance?.logo?.id}">${teamInstance?.logo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.memberships}">
				<li class="fieldcontain">
					<span id="memberships-label" class="property-label"><g:message code="team.memberships.label" default="Memberships" /></span>
					
						<g:each in="${teamInstance.memberships}" var="m">
						<span class="property-value" aria-labelledby="memberships-label"><g:link controller="membership" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.sessionGroups}">
				<li class="fieldcontain">
					<span id="sessionGroups-label" class="property-label"><g:message code="team.sessionGroups.label" default="Session Groups" /></span>
					
						<g:each in="${teamInstance.sessionGroups}" var="s">
						<span class="property-value" aria-labelledby="sessionGroups-label"><g:link controller="sessionGroup" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${teamInstance?.defaultSessionGroup}">
				<li class="fieldcontain">
					<span id="defaultSessionGroup-label" class="property-label"><g:message code="team.defaultSessionGroup.label" default="Default Session Group" /></span>
					
						<span class="property-value" aria-labelledby="defaultSessionGroup-label"><g:link controller="sessionGroup" action="show" id="${teamInstance?.defaultSessionGroup?.id}">${teamInstance?.defaultSessionGroup?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${teamInstance?.id}" />
					<g:link class="edit" action="edit" id="${teamInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
		
	</body>
</html>
