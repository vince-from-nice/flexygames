
<%@ page import="flexygames.GameAction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameAction.label', default: 'GameAction')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-gameAction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-gameAction" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list gameAction">
			
				<g:if test="${gameActionInstance?.sessionRound}">
				<li class="fieldcontain">
					<span id="sessionRound-label" class="property-label"><g:message code="gameAction.sessionRound.label" default="Session Round" /></span>
					
						<span class="property-value" aria-labelledby="sessionRound-label"><g:link controller="sessionRound" action="show" id="${gameActionInstance?.sessionRound?.id}">${gameActionInstance?.sessionRound?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${gameActionInstance?.mainContributor}">
				<li class="fieldcontain">
					<span id="mainContributor-label" class="property-label"><g:message code="gameAction.mainContributor.label" default="Main Contributor" /></span>
					
						<span class="property-value" aria-labelledby="mainContributor-label"><g:link controller="user" action="show" id="${gameActionInstance?.mainContributor?.id}">${gameActionInstance?.mainContributor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${gameActionInstance?.secondaryContributor}">
				<li class="fieldcontain">
					<span id="secondaryContributor-label" class="property-label"><g:message code="gameAction.secondaryContributor.label" default="Secondary Contributor" /></span>
					
						<span class="property-value" aria-labelledby="secondaryContributor-label"><g:link controller="user" action="show" id="${gameActionInstance?.secondaryContributor?.id}">${gameActionInstance?.secondaryContributor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${gameActionInstance?.forFirstTeamIfOrphelin}">
				<li class="fieldcontain">
					<span id="forFirstTeamIfOrphelin-label" class="property-label"><g:message code="gameAction.forFirstTeamIfOrphelin.label" default="For First Team If Orphelin" /></span>
					
						<span class="property-value" aria-labelledby="forFirstTeamIfOrphelin-label"><g:formatBoolean boolean="${gameActionInstance?.forFirstTeamIfOrphelin}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${gameActionInstance?.id}" />
					<g:link class="edit" action="edit" id="${gameActionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
