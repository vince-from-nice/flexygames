<%@ page import="flexygames.SessionComment" %>



<div class="fieldcontain ${hasErrors(bean: sessionCommentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="sessionComment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${sessionCommentInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionCommentInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="sessionComment.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${sessionCommentInstance?.session?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionCommentInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="sessionComment.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${sessionCommentInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: sessionCommentInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="sessionComment.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="text" cols="40" rows="5" maxlength="10000" required="" value="${sessionCommentInstance?.text}"/>

</div>

