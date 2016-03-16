
<%@ page import="flexygames.Membership" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'membership.label', default: 'Membership')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-membership" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-membership" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list membership">
			
				<g:if test="${membershipInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="membership.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${membershipInstance?.user?.id}">${membershipInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.team}">
				<li class="fieldcontain">
					<span id="team-label" class="property-label"><g:message code="membership.team.label" default="Team" /></span>
					
						<span class="property-value" aria-labelledby="team-label"><g:link controller="team" action="show" id="${membershipInstance?.team?.id}">${membershipInstance?.team?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.manager}">
				<li class="fieldcontain">
					<span id="manager-label" class="property-label"><g:message code="membership.manager.label" default="Manager" /></span>
					
						<span class="property-value" aria-labelledby="manager-label"><g:formatBoolean boolean="${membershipInstance?.manager}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.regularForTraining}">
				<li class="fieldcontain">
					<span id="regularForTraining-label" class="property-label"><g:message code="membership.regularForTraining.label" default="Regular For Training" /></span>
					
						<span class="property-value" aria-labelledby="regularForTraining-label"><g:formatBoolean boolean="${membershipInstance?.regularForTraining}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.regularForCompetition}">
				<li class="fieldcontain">
					<span id="regularForCompetition-label" class="property-label"><g:message code="membership.regularForCompetition.label" default="Regular For Competition" /></span>
					
						<span class="property-value" aria-labelledby="regularForCompetition-label"><g:formatBoolean boolean="${membershipInstance?.regularForCompetition}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.feesUpToDate}">
				<li class="fieldcontain">
					<span id="feesUpToDate-label" class="property-label"><g:message code="membership.feesUpToDate.label" default="Fees Up To Date" /></span>
					
						<span class="property-value" aria-labelledby="feesUpToDate-label"><g:formatBoolean boolean="${membershipInstance?.feesUpToDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${membershipInstance?.subscriptions}">
				<li class="fieldcontain">
					<span id="subscriptions-label" class="property-label"><g:message code="membership.subscriptions.label" default="Subscriptions" /></span>
					
						<g:each in="${membershipInstance.subscriptions}" var="s">
						<span class="property-value" aria-labelledby="subscriptions-label"><g:link controller="subscription" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${membershipInstance?.id}" />
					<g:link class="edit" action="edit" id="${membershipInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
