
<%@ page import="flexygames.SessionRound" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionRound.label', default: 'SessionRound')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sessionRound" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sessionRound" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sessionRound">
			
				<g:if test="${sessionRoundInstance?.session}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="sessionRound.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="session" action="show" id="${sessionRoundInstance?.session?.id}">${sessionRoundInstance?.session?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionRoundInstance?.playersForTeamA}">
				<li class="fieldcontain">
					<span id="playersForTeamA-label" class="property-label"><g:message code="sessionRound.playersForTeamA.label" default="Players For Team A" /></span>
					
						<g:each in="${sessionRoundInstance.playersForTeamA}" var="p">
						<span class="property-value" aria-labelledby="playersForTeamA-label"><g:link controller="user" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionRoundInstance?.playersForTeamB}">
				<li class="fieldcontain">
					<span id="playersForTeamB-label" class="property-label"><g:message code="sessionRound.playersForTeamB.label" default="Players For Team B" /></span>
					
						<g:each in="${sessionRoundInstance.playersForTeamB}" var="p">
						<span class="property-value" aria-labelledby="playersForTeamB-label"><g:link controller="user" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionRoundInstance?.actions}">
				<li class="fieldcontain">
					<span id="actions-label" class="property-label"><g:message code="sessionRound.actions.label" default="Actions" /></span>
					
						<g:each in="${sessionRoundInstance.actions}" var="a">
						<span class="property-value" aria-labelledby="actions-label"><g:link controller="gameAction" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sessionRoundInstance?.id}" />
					<g:link class="edit" action="edit" id="${sessionRoundInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
