<%@ page import="flexygames.SessionWatch" %>



<div class="fieldcontain ${hasErrors(bean: sessionWatchInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="sessionWatch.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${sessionWatchInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionWatchInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="sessionWatch.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${sessionWatchInstance?.user?.id}" class="many-to-one"/>
</div>

