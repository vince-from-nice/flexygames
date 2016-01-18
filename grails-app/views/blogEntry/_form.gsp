<%@ page import="flexygames.BlogEntry" %>



<div class="fieldcontain ${hasErrors(bean: blogEntryInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="blogEntry.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${blogEntryInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: blogEntryInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="blogEntry.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${blogEntryInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: blogEntryInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="blogEntry.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="text" cols="40" rows="5" maxlength="10000" required="" value="${blogEntryInstance?.text}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: blogEntryInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="blogEntry.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${blogEntryInstance?.title}"/>

</div>

