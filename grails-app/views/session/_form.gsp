<%@ page import="flexygames.Session" %>



<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="session.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${sessionInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'duration', 'error')} ">
	<label for="duration">
		<g:message code="session.duration.label" default="Duration" />
		
	</label>
	<g:field name="duration" type="number" min="1" value="${sessionInstance.duration}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'rdvBeforeStart', 'error')} ">
	<label for="rdvBeforeStart">
		<g:message code="session.rdvBeforeStart.label" default="Rdv Before Start" />
		
	</label>
	<g:field name="rdvBeforeStart" type="number" min="0" value="${sessionInstance.rdvBeforeStart}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="session.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${sessionInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="session.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${sessionInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'playground', 'error')} required">
	<label for="playground">
		<g:message code="session.playground.label" default="Playground" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="playground" name="playground.id" from="${flexygames.Playground.list()}" optionKey="id" required="" value="${sessionInstance?.playground?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="session.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="type" name="type.id" from="${flexygames.GameType.list()}" optionKey="id" required="" value="${sessionInstance?.type?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'group', 'error')} required">
	<label for="group">
		<g:message code="session.group.label" default="Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="group" name="group.id" from="${flexygames.SessionGroup.list()}" optionKey="id" required="" value="${sessionInstance?.group?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'participations', 'error')} ">
	<label for="participations">
		<g:message code="session.participations.label" default="Participations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.participations?}" var="p">
    <li><g:link controller="participation" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="participation" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'participation.label', default: 'Participation')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'reminders', 'error')} ">
	<label for="reminders">
		<g:message code="session.reminders.label" default="Reminders" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.reminders?}" var="r">
    <li><g:link controller="reminder" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="reminder" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'reminder.label', default: 'Reminder')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'rounds', 'error')} ">
	<label for="rounds">
		<g:message code="session.rounds.label" default="Rounds" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.rounds?}" var="r">
    <li><g:link controller="sessionRound" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sessionRound" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sessionRound.label', default: 'SessionRound')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'votes', 'error')} ">
	<label for="votes">
		<g:message code="session.votes.label" default="Votes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.votes?}" var="v">
    <li><g:link controller="vote" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="vote" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'vote.label', default: 'Vote')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="session.comments.label" default="Comments" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.comments?}" var="c">
    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="comment" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'imageUrl', 'error')} ">
	<label for="imageUrl">
		<g:message code="session.imageUrl.label" default="Image Url" />
		
	</label>
	<g:field type="url" name="imageUrl" value="${sessionInstance?.imageUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'galleryUrl', 'error')} ">
	<label for="galleryUrl">
		<g:message code="session.galleryUrl.label" default="Gallery Url" />
		
	</label>
	<g:field type="url" name="galleryUrl" value="${sessionInstance?.galleryUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'creation', 'error')} ">
	<label for="creation">
		<g:message code="session.creation.label" default="Creation" />
		
	</label>
	<g:datePicker name="creation" precision="day"  value="${sessionInstance?.creation}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="session.creator.label" default="Creator" />
		
	</label>
	<g:select id="creator" name="creator.id" from="${flexygames.User.list()}" optionKey="id" value="${sessionInstance?.creator?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'extraFieldName', 'error')} ">
	<label for="extraFieldName">
		<g:message code="session.extraFieldName.label" default="Extra Field Name" />
		
	</label>
	<g:textField name="extraFieldName" value="${sessionInstance?.extraFieldName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'extraFieldValue', 'error')} ">
	<label for="extraFieldValue">
		<g:message code="session.extraFieldValue.label" default="Extra Field Value" />
		
	</label>
	<g:textField name="extraFieldValue" value="${sessionInstance?.extraFieldValue}"/>
</div>

