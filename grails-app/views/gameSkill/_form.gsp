<%@ page import="flexygames.GameSkill" %>



<div class="fieldcontain ${hasErrors(bean: gameSkillInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="gameSkill.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="type" name="type.id" from="${flexygames.GameType.list()}" optionKey="id" required="" value="${gameSkillInstance?.type?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameSkillInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="gameSkill.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" required="" value="${gameSkillInstance?.code}"/>
</div>

