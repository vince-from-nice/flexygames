
<%@ page import="flexygames.SessionGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionGroup.label', default: 'SessionGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sessionGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sessionGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sessionGroup">
			
				<g:if test="${sessionGroupInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="sessionGroup.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${sessionGroupInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="sessionGroup.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${sessionGroupInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.competition}">
				<li class="fieldcontain">
					<span id="competition-label" class="property-label"><g:message code="sessionGroup.competition.label" default="Competition" /></span>
					
						<span class="property-value" aria-labelledby="competition-label"><g:formatBoolean boolean="${sessionGroupInstance?.competition}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.visible}">
				<li class="fieldcontain">
					<span id="visible-label" class="property-label"><g:message code="sessionGroup.visible.label" default="Visible" /></span>
					
						<span class="property-value" aria-labelledby="visible-label"><g:formatBoolean boolean="${sessionGroupInstance?.visible}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.sessions}">
				<li class="fieldcontain">
					<span id="sessions-label" class="property-label"><g:message code="sessionGroup.sessions.label" default="Sessions" /></span>
					
						<g:each in="${sessionGroupInstance.sessions}" var="s">
						<span class="property-value" aria-labelledby="sessions-label"><g:link controller="session" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultType}">
				<li class="fieldcontain">
					<span id="defaultType-label" class="property-label"><g:message code="sessionGroup.defaultType.label" default="Default Type" /></span>
					
						<span class="property-value" aria-labelledby="defaultType-label"><g:link controller="gameType" action="show" id="${sessionGroupInstance?.defaultType?.id}">${sessionGroupInstance?.defaultType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultTeams}">
				<li class="fieldcontain">
					<span id="defaultTeams-label" class="property-label"><g:message code="sessionGroup.defaultTeams.label" default="Default Teams" /></span>
					
						<g:each in="${sessionGroupInstance.defaultTeams}" var="d">
						<span class="property-value" aria-labelledby="defaultTeams-label"><g:link controller="team" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultPlayground}">
				<li class="fieldcontain">
					<span id="defaultPlayground-label" class="property-label"><g:message code="sessionGroup.defaultPlayground.label" default="Default Playground" /></span>
					
						<span class="property-value" aria-labelledby="defaultPlayground-label"><g:link controller="playground" action="show" id="${sessionGroupInstance?.defaultPlayground?.id}">${sessionGroupInstance?.defaultPlayground?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultDayOfWeek}">
				<li class="fieldcontain">
					<span id="defaultDayOfWeek-label" class="property-label"><g:message code="sessionGroup.defaultDayOfWeek.label" default="Default Day Of Week" /></span>
					
						<span class="property-value" aria-labelledby="defaultDayOfWeek-label"><g:fieldValue bean="${sessionGroupInstance}" field="defaultDayOfWeek"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultMinPlayerNbr}">
				<li class="fieldcontain">
					<span id="defaultMinPlayerNbr-label" class="property-label"><g:message code="sessionGroup.defaultMinPlayerNbr.label" default="Default Min Player Nbr" /></span>
					
						<span class="property-value" aria-labelledby="defaultMinPlayerNbr-label"><g:fieldValue bean="${sessionGroupInstance}" field="defaultMinPlayerNbr"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultMaxPlayerNbr}">
				<li class="fieldcontain">
					<span id="defaultMaxPlayerNbr-label" class="property-label"><g:message code="sessionGroup.defaultMaxPlayerNbr.label" default="Default Max Player Nbr" /></span>
					
						<span class="property-value" aria-labelledby="defaultMaxPlayerNbr-label"><g:fieldValue bean="${sessionGroupInstance}" field="defaultMaxPlayerNbr"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.defaultPreferredPlayerNbr}">
				<li class="fieldcontain">
					<span id="defaultPreferredPlayerNbr-label" class="property-label"><g:message code="sessionGroup.defaultPreferredPlayerNbr.label" default="Default Preferred Player Nbr" /></span>
					
						<span class="property-value" aria-labelledby="defaultPreferredPlayerNbr-label"><g:fieldValue bean="${sessionGroupInstance}" field="defaultPreferredPlayerNbr"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionGroupInstance?.lockingTime}">
				<li class="fieldcontain">
					<span id="lockingTime-label" class="property-label"><g:message code="sessionGroup.lockingTime.label" default="Locking Time" /></span>
					
						<span class="property-value" aria-labelledby="lockingTime-label"><g:fieldValue bean="${sessionGroupInstance}" field="lockingTime"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sessionGroupInstance?.id}" />
					<g:link class="edit" action="edit" id="${sessionGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
