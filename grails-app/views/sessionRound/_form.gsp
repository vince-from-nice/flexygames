<%@ page import="flexygames.SessionRound" %>



<div class="fieldcontain ${hasErrors(bean: sessionRoundInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="sessionRound.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${sessionRoundInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionRoundInstance, field: 'playersForTeamA', 'error')} ">
	<label for="playersForTeamA">
		<g:message code="sessionRound.playersForTeamA.label" default="Players For Team A" />
		
	</label>
	<g:select name="playersForTeamA" from="${flexygames.User.list()}" multiple="multiple" optionKey="id" size="5" value="${sessionRoundInstance?.playersForTeamA*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionRoundInstance, field: 'playersForTeamB', 'error')} ">
	<label for="playersForTeamB">
		<g:message code="sessionRound.playersForTeamB.label" default="Players For Team B" />
		
	</label>
	<g:select name="playersForTeamB" from="${flexygames.User.list()}" multiple="multiple" optionKey="id" size="5" value="${sessionRoundInstance?.playersForTeamB*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionRoundInstance, field: 'actions', 'error')} ">
	<label for="actions">
		<g:message code="sessionRound.actions.label" default="Actions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionRoundInstance?.actions?}" var="a">
    <li><g:link controller="gameAction" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="gameAction" action="create" params="['sessionRound.id': sessionRoundInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'gameAction.label', default: 'GameAction')])}</g:link>
</li>
</ul>

</div>

