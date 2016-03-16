
<%@ page import="flexygames.Reminder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'reminder.label', default: 'Reminder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-reminder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-reminder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list reminder">
			
				<g:if test="${reminderInstance?.session}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="reminder.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="session" action="show" id="${reminderInstance?.session?.id}">${reminderInstance?.session?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${reminderInstance?.minutesBeforeSession}">
				<li class="fieldcontain">
					<span id="minutesBeforeSession-label" class="property-label"><g:message code="reminder.minutesBeforeSession.label" default="Minutes Before Session" /></span>
					
						<span class="property-value" aria-labelledby="minutesBeforeSession-label"><g:fieldValue bean="${reminderInstance}" field="minutesBeforeSession"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reminderInstance?.jobExecuted}">
				<li class="fieldcontain">
					<span id="jobExecuted-label" class="property-label"><g:message code="reminder.jobExecuted.label" default="Job Executed" /></span>
					
						<span class="property-value" aria-labelledby="jobExecuted-label"><g:formatBoolean boolean="${reminderInstance?.jobExecuted}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${reminderInstance?.id}" />
					<g:link class="edit" action="edit" id="${reminderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
