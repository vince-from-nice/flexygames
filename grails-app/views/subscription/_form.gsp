<%@ page import="flexygames.Subscription" %>



<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'membership', 'error')} required">
	<label for="membership">
		<g:message code="subscription.membership.label" default="Membership" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="membership" name="membership.id" from="${flexygames.Membership.list()}" optionKey="id" required="" value="${subscriptionInstance?.membership?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="subscription.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${subscriptionInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="subscription.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: subscriptionInstance, field: 'amount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: subscriptionInstance, field: 'currency', 'error')} required">
	<label for="currency">
		<g:message code="subscription.currency.label" default="Currency" />
		<span class="required-indicator">*</span>
	</label>
	<g:currencySelect name="currency" value="${subscriptionInstance?.currency}"  />
</div>

