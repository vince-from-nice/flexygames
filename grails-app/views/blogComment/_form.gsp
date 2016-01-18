<%@ page import="flexygames.BlogComment" %>



<div class="fieldcontain ${hasErrors(bean: blogCommentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="blogComment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${blogCommentInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: blogCommentInstance, field: 'blogEntry', 'error')} required">
	<label for="blogEntry">
		<g:message code="blogComment.blogEntry.label" default="Blog Entry" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="blogEntry" name="blogEntry.id" from="${flexygames.BlogEntry.list()}" optionKey="id" required="" value="${blogCommentInstance?.blogEntry?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: blogCommentInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="blogComment.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${blogCommentInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: blogCommentInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="blogComment.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="text" cols="40" rows="5" maxlength="10000" required="" value="${blogCommentInstance?.text}"/>

</div>

