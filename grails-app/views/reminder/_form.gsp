<%@ page import="flexygames.Reminder" %>



<div class="fieldcontain ${hasErrors(bean: reminderInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="reminder.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${reminderInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reminderInstance, field: 'minutesBeforeSession', 'error')} required">
	<label for="minutesBeforeSession">
		<g:message code="reminder.minutesBeforeSession.label" default="Minutes Before Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="minutesBeforeSession" min="0" required="" value="${fieldValue(bean: reminderInstance, field: 'minutesBeforeSession')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reminderInstance, field: 'jobExecuted', 'error')} ">
	<label for="jobExecuted">
		<g:message code="reminder.jobExecuted.label" default="Job Executed" />
		
	</label>
	<g:checkBox name="jobExecuted" value="${reminderInstance?.jobExecuted}" />
</div>

