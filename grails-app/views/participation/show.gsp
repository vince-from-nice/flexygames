
<%@ page import="flexygames.Participation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'participation.label', default: 'Participation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-participation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-participation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list participation">
			
				<g:if test="${participationInstance?.player}">
				<li class="fieldcontain">
					<span id="player-label" class="property-label"><g:message code="participation.player.label" default="Player" /></span>
					
						<span class="property-value" aria-labelledby="player-label"><g:link controller="user" action="show" id="${participationInstance?.player?.id}">${participationInstance?.player?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${participationInstance?.session}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="participation.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="session" action="show" id="${participationInstance?.session?.id}">${participationInstance?.session?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${participationInstance?.statusCode}">
				<li class="fieldcontain">
					<span id="statusCode-label" class="property-label"><g:message code="participation.statusCode.label" default="Status Code" /></span>
					
						<span class="property-value" aria-labelledby="statusCode-label"><g:fieldValue bean="${participationInstance}" field="statusCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${participationInstance?.userLog}">
				<li class="fieldcontain">
					<span id="userLog-label" class="property-label"><g:message code="participation.userLog.label" default="User Log" /></span>
					
						<span class="property-value" aria-labelledby="userLog-label"><g:fieldValue bean="${participationInstance}" field="userLog"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${participationInstance?.lastUpdate}">
				<li class="fieldcontain">
					<span id="lastUpdate-label" class="property-label"><g:message code="participation.lastUpdate.label" default="Last Update" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdate-label"><g:formatDate date="${participationInstance?.lastUpdate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${participationInstance?.lastUpdater}">
				<li class="fieldcontain">
					<span id="lastUpdater-label" class="property-label"><g:message code="participation.lastUpdater.label" default="Last Updater" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdater-label"><g:fieldValue bean="${participationInstance}" field="lastUpdater"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${participationInstance?.id}" />
					<g:link class="edit" action="edit" id="${participationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
