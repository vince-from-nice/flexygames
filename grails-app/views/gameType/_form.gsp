<%@ page import="flexygames.GameType" %>



<div class="fieldcontain ${hasErrors(bean: gameTypeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="gameType.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${gameTypeInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameTypeInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="gameType.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${gameTypeInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameTypeInstance, field: 'skills', 'error')} ">
	<label for="skills">
		<g:message code="gameType.skills.label" default="Skills" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${gameTypeInstance?.skills?}" var="s">
    <li><g:link controller="gameSkill" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="gameSkill" action="create" params="['gameType.id': gameTypeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'gameSkill.label', default: 'GameSkill')])}</g:link>
</li>
</ul>

</div>

