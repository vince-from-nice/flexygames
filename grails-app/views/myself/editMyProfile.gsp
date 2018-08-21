<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
	<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<div class="body">
		<h1><g:message code="myAccount.editPersonalInfos" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div><br/>
		</g:if>
		<g:if test="${flash.error}">
			<div class="errors">${flash.error}</div>
		</g:if>
		<g:hasErrors bean="${playerInstance}">
			<div class="errors">
				<g:renderErrors bean="${playerInstance}" as="list" />
			</div><br />
		</g:hasErrors>
		<g:form method="post">
			<g:hiddenField name="version" value="${playerInstance?.version}" />
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="username"><g:message code="username" default="Username" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'username', 'errors')}">
								<b>${playerInstance?.username}</b>
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.username.notes" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="firstName">
								<g:message code="firstName" default="First Name" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'firstName', 'errors')}">
								<g:textField name="firstName" value="${playerInstance?.firstName}" />
							</td>
							<td>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="lastName"><g:message code="lastName" default="Last Name" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'lastName', 'errors')}">
								<g:textField name="lastName" value="${playerInstance?.lastName}" />
							</td>
							<td>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="email">
								<g:message code="email" default="Email" /> <font color="red">*</font> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'email', 'errors')}">
								<g:textField name="email" value="${playerInstance?.email}" />
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.email.notes" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="phoneNumber"><g:message code="phoneNumber" default="Phone Number" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'phoneNumber', 'errors')}">
								<g:textField name="phoneNumber" value="${playerInstance?.phoneNumber}" />
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.phone.notes" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="city"><g:message code="city" default="City" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'city', 'errors')}">
								<g:textField name="city" value="${playerInstance?.city}" />
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.city.notes" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="company"><g:message code="company" default="Company" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'company', 'errors')}">
								<g:textField name="company" value="${playerInstance?.company}" />
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.company.notes" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="yearBirthDate"><g:message code="yearDate" default="Birth Date" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'yearBirthDate', 'errors')}">
								<g:select name="yearBirthDate" from="${1950..2012}" value="${playerInstance?.yearBirthDate}" />
							</td>
							<td style="font-size: 12px">
								<g:message code="myAccount.profile.yearDate.notes" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="buttons">
				<span class="button"> 
					<g:actionSubmit class="save" action="updateMyProfile" value="${message(code: 'myAccount.profile.update', default: 'Update')}" /> 
				</span>
			</div>
		</g:form>
	</div>
</body>
</html>
