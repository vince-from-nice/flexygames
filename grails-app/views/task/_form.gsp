<%@ page import="flexygames.Task" %>



<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="task.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${taskInstance?.session?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="task.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="type" name="type.id" from="${flexygames.TaskType.list()}" optionKey="id" required="" value="${taskInstance?.type?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="task.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${taskInstance?.user?.id}" class="many-to-one"/>

</div>

