
<%@ page import="flexygames.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.roles}">
				<li class="fieldcontain">
					<span id="roles-label" class="property-label"><g:message code="user.roles.label" default="Roles" /></span>
					
						<g:each in="${userInstance.roles}" var="r">
						<span class="property-value" aria-labelledby="roles-label"><g:link controller="role" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.firstName}">
				<li class="fieldcontain">
					<span id="firstName-label" class="property-label"><g:message code="user.firstName.label" default="First Name" /></span>
					
						<span class="property-value" aria-labelledby="firstName-label"><g:fieldValue bean="${userInstance}" field="firstName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.lastName}">
				<li class="fieldcontain">
					<span id="lastName-label" class="property-label"><g:message code="user.lastName.label" default="Last Name" /></span>
					
						<span class="property-value" aria-labelledby="lastName-label"><g:fieldValue bean="${userInstance}" field="lastName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="user.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.phoneNumber}">
				<li class="fieldcontain">
					<span id="phoneNumber-label" class="property-label"><g:message code="user.phoneNumber.label" default="Phone Number" /></span>
					
						<span class="property-value" aria-labelledby="phoneNumber-label"><g:fieldValue bean="${userInstance}" field="phoneNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.company}">
				<li class="fieldcontain">
					<span id="company-label" class="property-label"><g:message code="user.company.label" default="Company" /></span>
					
						<span class="property-value" aria-labelledby="company-label"><g:fieldValue bean="${userInstance}" field="company"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="user.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${userInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.yearBirthDate}">
				<li class="fieldcontain">
					<span id="yearBirthDate-label" class="property-label"><g:message code="user.yearBirthDate.label" default="Year Birth Date" /></span>
					
						<span class="property-value" aria-labelledby="yearBirthDate-label"><g:fieldValue bean="${userInstance}" field="yearBirthDate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.registrationDate}">
				<li class="fieldcontain">
					<span id="registrationDate-label" class="property-label"><g:message code="user.registrationDate.label" default="Registration Date" /></span>
					
						<span class="property-value" aria-labelledby="registrationDate-label"><g:formatDate date="${userInstance?.registrationDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.avatar}">
				<li class="fieldcontain">
					<span id="avatar-label" class="property-label"><g:message code="user.avatar.label" default="Avatar" /></span>
					
						<span class="property-value" aria-labelledby="avatar-label"><g:link controller="UFile" action="show" id="${userInstance?.avatar?.id}">${userInstance?.avatar?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.memberships}">
				<li class="fieldcontain">
					<span id="memberships-label" class="property-label"><g:message code="user.memberships.label" default="Memberships" /></span>
					
						<g:each in="${userInstance.memberships}" var="m">
						<span class="property-value" aria-labelledby="memberships-label"><g:link controller="membership" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.skills}">
				<li class="fieldcontain">
					<span id="skills-label" class="property-label"><g:message code="user.skills.label" default="Skills" /></span>
					
						<g:each in="${userInstance.skills}" var="s">
						<span class="property-value" aria-labelledby="skills-label"><g:link controller="gameSkill" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.participations}">
				<li class="fieldcontain">
					<span id="participations-label" class="property-label"><g:message code="user.participations.label" default="Participations" /></span>
					
						<g:each in="${userInstance.participations}" var="p">
						<span class="property-value" aria-labelledby="participations-label"><g:link controller="participation" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.actions}">
				<li class="fieldcontain">
					<span id="actions-label" class="property-label"><g:message code="user.actions.label" default="Actions" /></span>
					
						<g:each in="${userInstance.actions}" var="a">
						<span class="property-value" aria-labelledby="actions-label"><g:link controller="gameAction" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.passwordResetToken}">
				<li class="fieldcontain">
					<span id="passwordResetToken-label" class="property-label"><g:message code="user.passwordResetToken.label" default="Password Reset Token" /></span>
					
						<span class="property-value" aria-labelledby="passwordResetToken-label"><g:fieldValue bean="${userInstance}" field="passwordResetToken"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.passwordResetExpiration}">
				<li class="fieldcontain">
					<span id="passwordResetExpiration-label" class="property-label"><g:message code="user.passwordResetExpiration.label" default="Password Reset Expiration" /></span>
					
						<span class="property-value" aria-labelledby="passwordResetExpiration-label"><g:formatDate date="${userInstance?.passwordResetExpiration}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.lastLogin}">
				<li class="fieldcontain">
					<span id="lastLogin-label" class="property-label"><g:message code="user.lastLogin.label" default="Last Login" /></span>
					
						<span class="property-value" aria-labelledby="lastLogin-label"><g:formatDate date="${userInstance?.lastLogin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.lastLogout}">
				<li class="fieldcontain">
					<span id="lastLogout-label" class="property-label"><g:message code="user.lastLogout.label" default="Last Logout" /></span>
					
						<span class="property-value" aria-labelledby="lastLogout-label"><g:formatDate date="${userInstance?.lastLogout}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.calendarToken}">
				<li class="fieldcontain">
					<span id="calendarToken-label" class="property-label"><g:message code="user.calendarToken.label" default="Calendar Token" /></span>
					
						<span class="property-value" aria-labelledby="calendarToken-label"><g:fieldValue bean="${userInstance}" field="calendarToken"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.passwordHash}">
				<li class="fieldcontain">
					<span id="passwordHash-label" class="property-label"><g:message code="user.passwordHash.label" default="Password Hash" /></span>
					
						<span class="property-value" aria-labelledby="passwordHash-label"><g:fieldValue bean="${userInstance}" field="passwordHash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.permissions}">
				<li class="fieldcontain">
					<span id="permissions-label" class="property-label"><g:message code="user.permissions.label" default="Permissions" /></span>
					
						<span class="property-value" aria-labelledby="permissions-label"><g:fieldValue bean="${userInstance}" field="permissions"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.votes}">
				<li class="fieldcontain">
					<span id="votes-label" class="property-label"><g:message code="user.votes.label" default="Votes" /></span>
					
						<g:each in="${userInstance.votes}" var="v">
						<span class="property-value" aria-labelledby="votes-label"><g:link controller="vote" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${userInstance?.id}" />
					<g:link class="edit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
