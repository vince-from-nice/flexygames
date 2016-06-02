<%@ page import="flexygames.TaskType" %>



<div class="fieldcontain ${hasErrors(bean: taskTypeInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="taskType.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" required="" value="${taskTypeInstance?.code}"/>

</div>

