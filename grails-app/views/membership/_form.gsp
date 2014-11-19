<%@ page import="flexygames.Membership" %>



<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="membership.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${membershipInstance?.user?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'team', 'error')} required">
	<label for="team">
		<g:message code="membership.team.label" default="Team" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="team" name="team.id" from="${flexygames.Team.list()}" optionKey="id" required="" value="${membershipInstance?.team?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'manager', 'error')} ">
	<label for="manager">
		<g:message code="membership.manager.label" default="Manager" />
		
	</label>
	<g:checkBox name="manager" value="${membershipInstance?.manager}" />
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'regularForTraining', 'error')} ">
	<label for="regularForTraining">
		<g:message code="membership.regularForTraining.label" default="Regular For Training" />
		
	</label>
	<g:checkBox name="regularForTraining" value="${membershipInstance?.regularForTraining}" />
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'regularForCompetition', 'error')} ">
	<label for="regularForCompetition">
		<g:message code="membership.regularForCompetition.label" default="Regular For Competition" />
		
	</label>
	<g:checkBox name="regularForCompetition" value="${membershipInstance?.regularForCompetition}" />
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'feesUpToDate', 'error')} ">
	<label for="feesUpToDate">
		<g:message code="membership.feesUpToDate.label" default="Fees Up To Date" />
		
	</label>
	<g:checkBox name="feesUpToDate" value="${membershipInstance?.feesUpToDate}" />
</div>

<div class="fieldcontain ${hasErrors(bean: membershipInstance, field: 'subscriptions', 'error')} ">
	<label for="subscriptions">
		<g:message code="membership.subscriptions.label" default="Subscriptions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${membershipInstance?.subscriptions?}" var="s">
    <li><g:link controller="subscription" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="subscription" action="create" params="['membership.id': membershipInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'subscription.label', default: 'Subscription')])}</g:link>
</li>
</ul>

</div>

