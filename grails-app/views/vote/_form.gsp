<%@ page import="flexygames.Vote" %>



<div class="fieldcontain ${hasErrors(bean: voteInstance, field: 'player', 'error')} required">
	<label for="player">
		<g:message code="vote.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="player" name="player.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${voteInstance?.player?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: voteInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="vote.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="score" required="" value="${fieldValue(bean: voteInstance, field: 'score')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: voteInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="vote.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${voteInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: voteInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="vote.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${voteInstance?.user?.id}" class="many-to-one"/>
</div>

