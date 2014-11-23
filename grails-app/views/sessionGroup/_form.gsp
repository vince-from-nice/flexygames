<%@ page import="flexygames.SessionGroup" %>



<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="sessionGroup.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${sessionGroupInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="sessionGroup.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${sessionGroupInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'competition', 'error')} ">
	<label for="competition">
		<g:message code="sessionGroup.competition.label" default="Competition" />
		
	</label>
	<g:checkBox name="competition" value="${sessionGroupInstance?.competition}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'visible', 'error')} ">
	<label for="visible">
		<g:message code="sessionGroup.visible.label" default="Visible" />
		
	</label>
	<g:checkBox name="visible" value="${sessionGroupInstance?.visible}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'sessions', 'error')} ">
	<label for="sessions">
		<g:message code="sessionGroup.sessions.label" default="Sessions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionGroupInstance?.sessions?}" var="s">
    <li><g:link controller="session" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="session" action="create" params="['sessionGroup.id': sessionGroupInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'session.label', default: 'Session')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultType', 'error')} required">
	<label for="defaultType">
		<g:message code="sessionGroup.defaultType.label" default="Default Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="defaultType" name="defaultType.id" from="${flexygames.GameType.list()}" optionKey="id" required="" value="${sessionGroupInstance?.defaultType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultTeams', 'error')} ">
	<label for="defaultTeams">
		<g:message code="sessionGroup.defaultTeams.label" default="Default Teams" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultPlayground', 'error')} ">
	<label for="defaultPlayground">
		<g:message code="sessionGroup.defaultPlayground.label" default="Default Playground" />
		
	</label>
	<g:select id="defaultPlayground" name="defaultPlayground.id" from="${flexygames.Playground.list()}" optionKey="id" value="${sessionGroupInstance?.defaultPlayground?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultDayOfWeek', 'error')} required">
	<label for="defaultDayOfWeek">
		<g:message code="sessionGroup.defaultDayOfWeek.label" default="Default Day Of Week" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="defaultDayOfWeek" type="number" value="${sessionGroupInstance.defaultDayOfWeek}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultMinPlayerNbr', 'error')} required">
	<label for="defaultMinPlayerNbr">
		<g:message code="sessionGroup.defaultMinPlayerNbr.label" default="Default Min Player Nbr" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="defaultMinPlayerNbr" type="number" min="1" value="${sessionGroupInstance.defaultMinPlayerNbr}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultMaxPlayerNbr', 'error')} required">
	<label for="defaultMaxPlayerNbr">
		<g:message code="sessionGroup.defaultMaxPlayerNbr.label" default="Default Max Player Nbr" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="defaultMaxPlayerNbr" type="number" min="1" value="${sessionGroupInstance.defaultMaxPlayerNbr}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'defaultPreferredPlayerNbr', 'error')} required">
	<label for="defaultPreferredPlayerNbr">
		<g:message code="sessionGroup.defaultPreferredPlayerNbr.label" default="Default Preferred Player Nbr" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="defaultPreferredPlayerNbr" type="number" min="1" value="${sessionGroupInstance.defaultPreferredPlayerNbr}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionGroupInstance, field: 'lockingTime', 'error')} required">
	<label for="lockingTime">
		<g:message code="sessionGroup.lockingTime.label" default="Locking Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="lockingTime" type="number" min="0" value="${sessionGroupInstance.lockingTime}" required=""/>
</div>
