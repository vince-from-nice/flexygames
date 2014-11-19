<%@ page import="flexygames.GameAction" %>



<div class="fieldcontain ${hasErrors(bean: gameActionInstance, field: 'sessionRound', 'error')} required">
	<label for="sessionRound">
		<g:message code="gameAction.sessionRound.label" default="Session Round" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sessionRound" name="sessionRound.id" from="${flexygames.SessionRound.list()}" optionKey="id" required="" value="${gameActionInstance?.sessionRound?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameActionInstance, field: 'mainContributor', 'error')} ">
	<label for="mainContributor">
		<g:message code="gameAction.mainContributor.label" default="Main Contributor" />
		
	</label>
	<g:select id="mainContributor" name="mainContributor.id" from="${flexygames.User.list()}" optionKey="id" value="${gameActionInstance?.mainContributor?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameActionInstance, field: 'secondaryContributor', 'error')} ">
	<label for="secondaryContributor">
		<g:message code="gameAction.secondaryContributor.label" default="Secondary Contributor" />
		
	</label>
	<g:select id="secondaryContributor" name="secondaryContributor.id" from="${flexygames.User.list()}" optionKey="id" value="${gameActionInstance?.secondaryContributor?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameActionInstance, field: 'forFirstTeamIfOrphelin', 'error')} ">
	<label for="forFirstTeamIfOrphelin">
		<g:message code="gameAction.forFirstTeamIfOrphelin.label" default="For First Team If Orphelin" />
		
	</label>
	<g:checkBox name="forFirstTeamIfOrphelin" value="${gameActionInstance?.forFirstTeamIfOrphelin}" />
</div>

