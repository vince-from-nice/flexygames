<%@ page import="flexygames.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'roles', 'error')} required">
	<label for="roles">
		<g:message code="user.roles.label" default="Roles" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="roles" from="${flexygames.Role.list()}" multiple="multiple" optionKey="id" size="5" required="" value="${userInstance?.roles*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'firstName', 'error')} ">
	<label for="firstName">
		<g:message code="user.firstName.label" default="First Name" />
		
	</label>
	<g:textField name="firstName" value="${userInstance?.firstName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastName', 'error')} ">
	<label for="lastName">
		<g:message code="user.lastName.label" default="Last Name" />
		
	</label>
	<g:textField name="lastName" value="${userInstance?.lastName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${userInstance?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phoneNumber', 'error')} ">
	<label for="phoneNumber">
		<g:message code="user.phoneNumber.label" default="Phone Number" />
		
	</label>
	<g:textField name="phoneNumber" value="${userInstance?.phoneNumber}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'company', 'error')} ">
	<label for="company">
		<g:message code="user.company.label" default="Company" />
		
	</label>
	<g:textField name="company" value="${userInstance?.company}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'city', 'error')} ">
	<label for="city">
		<g:message code="user.city.label" default="City" />
		
	</label>
	<g:textField name="city" value="${userInstance?.city}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'yearBirthDate', 'error')} ">
	<label for="yearBirthDate">
		<g:message code="user.yearBirthDate.label" default="Year Birth Date" />
		
	</label>
	<g:select name="yearBirthDate" from="${1950..2012}" class="range" value="${fieldValue(bean: userInstance, field: 'yearBirthDate')}" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'registrationDate', 'error')} required">
	<label for="registrationDate">
		<g:message code="user.registrationDate.label" default="Registration Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="registrationDate" precision="day"  value="${userInstance?.registrationDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'avatarName', 'error')} ">
	<label for="avatarName">
		<g:message code="user.avatarName.label" default="Avatar Name" />
		
	</label>
	<g:textField name="avatarName" value="${userInstance?.avatarName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'memberships', 'error')} ">
	<label for="memberships">
		<g:message code="user.memberships.label" default="Memberships" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${userInstance?.memberships?}" var="m">
    <li><g:link controller="membership" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="membership" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'membership.label', default: 'Membership')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'skills', 'error')} ">
	<label for="skills">
		<g:message code="user.skills.label" default="Skills" />
		
	</label>
	<g:select name="skills" from="${flexygames.GameSkill.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.skills*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'participations', 'error')} ">
	<label for="participations">
		<g:message code="user.participations.label" default="Participations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${userInstance?.participations?}" var="p">
    <li><g:link controller="participation" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="participation" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'participation.label', default: 'Participation')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'actions', 'error')} ">
	<label for="actions">
		<g:message code="user.actions.label" default="Actions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${userInstance?.actions?}" var="a">
    <li><g:link controller="gameAction" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="gameAction" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'gameAction.label', default: 'GameAction')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordResetToken', 'error')} ">
	<label for="passwordResetToken">
		<g:message code="user.passwordResetToken.label" default="Password Reset Token" />
		
	</label>
	<g:textField name="passwordResetToken" value="${userInstance?.passwordResetToken}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordResetExpiration', 'error')} ">
	<label for="passwordResetExpiration">
		<g:message code="user.passwordResetExpiration.label" default="Password Reset Expiration" />
		
	</label>
	<g:datePicker name="passwordResetExpiration" precision="day"  value="${userInstance?.passwordResetExpiration}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastLogin', 'error')} ">
	<label for="lastLogin">
		<g:message code="user.lastLogin.label" default="Last Login" />
		
	</label>
	<g:datePicker name="lastLogin" precision="day"  value="${userInstance?.lastLogin}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastLogout', 'error')} ">
	<label for="lastLogout">
		<g:message code="user.lastLogout.label" default="Last Logout" />
		
	</label>
	<g:datePicker name="lastLogout" precision="day"  value="${userInstance?.lastLogout}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'calendarToken', 'error')} ">
	<label for="calendarToken">
		<g:message code="user.calendarToken.label" default="Calendar Token" />
		
	</label>
	<g:textField name="calendarToken" value="${userInstance?.calendarToken}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'partCounter', 'error')} ">
	<label for="partCounter">
		<g:message code="user.partCounter.label" default="Part Counter" />
		
	</label>
	<g:field name="partCounter" type="number" value="${userInstance.partCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'absenceCounter', 'error')} ">
	<label for="absenceCounter">
		<g:message code="user.absenceCounter.label" default="Absence Counter" />
		
	</label>
	<g:field name="absenceCounter" type="number" value="${userInstance.absenceCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'gateCrashCounter', 'error')} ">
	<label for="gateCrashCounter">
		<g:message code="user.gateCrashCounter.label" default="Gate Crash Counter" />
		
	</label>
	<g:field name="gateCrashCounter" type="number" value="${userInstance.gateCrashCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'actionCounter', 'error')} ">
	<label for="actionCounter">
		<g:message code="user.actionCounter.label" default="Action Counter" />
		
	</label>
	<g:field name="actionCounter" type="number" value="${userInstance.actionCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'voteCounter', 'error')} ">
	<label for="voteCounter">
		<g:message code="user.voteCounter.label" default="Vote Counter" />
		
	</label>
	<g:field name="voteCounter" type="number" value="${userInstance.voteCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'commentCounter', 'error')} ">
	<label for="commentCounter">
		<g:message code="user.commentCounter.label" default="Comment Counter" />
		
	</label>
	<g:field name="commentCounter" type="number" value="${userInstance.commentCounter}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordHash', 'error')} required">
	<label for="passwordHash">
		<g:message code="user.passwordHash.label" default="Password Hash" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="passwordHash" required="" value="${userInstance?.passwordHash}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'permissions', 'error')} ">
	<label for="permissions">
		<g:message code="user.permissions.label" default="Permissions" />
		
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'votes', 'error')} ">
	<label for="votes">
		<g:message code="user.votes.label" default="Votes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${userInstance?.votes?}" var="v">
    <li><g:link controller="vote" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="vote" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'vote.label', default: 'Vote')])}</g:link>
</li>
</ul>


</div>

