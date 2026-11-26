<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<div class="card form-card">
		<h1><g:message code="myAccount.editPersonalInfos" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="errors">${flash.error}</div>
		</g:if>
		<g:hasErrors bean="${playerInstance}">
			<div class="errors">
				<g:renderErrors bean="${playerInstance}" as="list" />
			</div>
		</g:hasErrors>
		<g:form method="post">
			<g:hiddenField name="version" value="${playerInstance?.version}" />
			<div class="field">
				<span class="field-label"><g:message code="username" default="Username" /></span>
				<strong>${playerInstance?.username}</strong>
				<p class="field-help"><g:message code="myAccount.profile.username.notes" /></p>
			</div>
			<div class="field-row">
				<div class="field ${hasErrors(bean: playerInstance, field: 'firstName', 'error')}">
					<label for="firstName"><g:message code="firstName" default="First Name" /></label>
					<g:textField name="firstName" value="${playerInstance?.firstName}" autocomplete="given-name" />
				</div>
				<div class="field ${hasErrors(bean: playerInstance, field: 'lastName', 'error')}">
					<label for="lastName"><g:message code="lastName" default="Last Name" /></label>
					<g:textField name="lastName" value="${playerInstance?.lastName}" autocomplete="family-name" />
				</div>
			</div>
			<div class="field ${hasErrors(bean: playerInstance, field: 'email', 'error')}">
				<label for="email"><g:message code="email" default="Email" /> <span class="required-mark">*</span></label>
				<g:textField name="email" value="${playerInstance?.email}" autocomplete="email" required="" />
				<p class="field-help"><g:message code="myAccount.profile.email.notes" /></p>
			</div>
			<div class="field ${hasErrors(bean: playerInstance, field: 'phoneNumber', 'error')}">
				<label for="phoneNumber"><g:message code="phoneNumber" default="Phone Number" /></label>
				<g:textField name="phoneNumber" value="${playerInstance?.phoneNumber}" autocomplete="tel" />
				<p class="field-help"><g:message code="myAccount.profile.phone.notes" /></p>
			</div>
			<div class="field ${hasErrors(bean: playerInstance, field: 'city', 'error')}">
				<label for="city"><g:message code="city" default="City" /></label>
				<g:textField name="city" value="${playerInstance?.city}" autocomplete="address-level2" />
				<p class="field-help"><g:message code="myAccount.profile.city.notes" /></p>
			</div>
			<div class="field ${hasErrors(bean: playerInstance, field: 'company', 'error')}">
				<label for="company"><g:message code="company" default="Company" /></label>
				<g:textField name="company" value="${playerInstance?.company}" autocomplete="organization" />
				<p class="field-help"><g:message code="myAccount.profile.company.notes" /></p>
			</div>
			<div class="field field-short ${hasErrors(bean: playerInstance, field: 'yearBirthDate', 'error')}">
				<label for="yearBirthDate"><g:message code="yearDate" default="Birth Date" /></label>
				<g:select name="yearBirthDate" from="${1950..2012}" value="${playerInstance?.yearBirthDate}" />
				<p class="field-help"><g:message code="myAccount.profile.yearDate.notes" /></p>
			</div>
			<div class="form-actions">
				<g:actionSubmit class="save" action="updateMyProfile" value="${message(code: 'myAccount.profile.update', default: 'Update')}" />
				<g:link controller="myself" action="myAccount" class="btn btn-ghost"><g:message code="cancel" default="Cancel" /></g:link>
			</div>
		</g:form>
	</div>
</body>
</html>
