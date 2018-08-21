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

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'lockingTime', 'error')} ">
	<label for="lockingTime">
		<g:message code="session.lockingTime.label" default="Locking Time" />
		
	</label>
	<g:field name="lockingTime" type="number" min="0" value="${sessionInstance.lockingTime}"/>

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
    <li><g:link controller="sessionComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sessionComment" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sessionComment.label', default: 'SessionComment')])}</g:link>
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

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'compositions', 'error')} ">
	<label for="compositions">
		<g:message code="session.compositions.label" default="Compositions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.compositions?}" var="c">
    <li><g:link controller="composition" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="composition" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'composition.label', default: 'Composition')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'lastUpdate', 'error')} ">
	<label for="lastUpdate">
		<g:message code="session.lastUpdate.label" default="Last Update" />
		
	</label>
	<g:datePicker name="lastUpdate" precision="day"  value="${sessionInstance?.lastUpdate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'lastUpdater', 'error')} ">
	<label for="lastUpdater">
		<g:message code="session.lastUpdater.label" default="Last Updater" />
		
	</label>
	<g:select id="lastUpdater" name="lastUpdater.id" from="${flexygames.User.list()}" optionKey="id" value="${sessionInstance?.lastUpdater?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'canceled', 'error')} ">
	<label for="canceled">
		<g:message code="session.canceled.label" default="Canceled" />
		
	</label>
	<g:checkBox name="canceled" value="${sessionInstance?.canceled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'cancelationLog', 'error')} ">
	<label for="cancelationLog">
		<g:message code="session.cancelationLog.label" default="Cancelation Log" />
		
	</label>
	<g:textField name="cancelationLog" value="${sessionInstance?.cancelationLog}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'cancelationUser', 'error')} ">
	<label for="cancelationUser">
		<g:message code="session.cancelationUser.label" default="Cancelation User" />
		
	</label>
	<g:select id="cancelationUser" name="cancelationUser.id" from="${flexygames.User.list()}" optionKey="id" value="${sessionInstance?.cancelationUser?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'cancelationDate', 'error')} ">
	<label for="cancelationDate">
		<g:message code="session.cancelationDate.label" default="Cancelation Date" />
		
	</label>
	<g:datePicker name="cancelationDate" precision="day"  value="${sessionInstance?.cancelationDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'carpoolProposals', 'error')} ">
	<label for="carpoolProposals">
		<g:message code="session.carpoolProposals.label" default="Carpool Proposals" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.carpoolProposals?}" var="c">
    <li><g:link controller="carpoolProposal" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="carpoolProposal" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'carpoolRequests', 'error')} ">
	<label for="carpoolRequests">
		<g:message code="session.carpoolRequests.label" default="Carpool Requests" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.carpoolRequests?}" var="c">
    <li><g:link controller="carpoolRequest" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="carpoolRequest" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'tasks', 'error')} ">
	<label for="tasks">
		<g:message code="session.tasks.label" default="Tasks" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.tasks?}" var="t">
    <li><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="task" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'task.label', default: 'Task')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'watchers', 'error')} ">
	<label for="watchers">
		<g:message code="session.watchers.label" default="Watchers" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionInstance?.watchers?}" var="w">
    <li><g:link controller="sessionWatcher" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sessionWatcher" action="create" params="['session.id': sessionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sessionWatcher.label', default: 'SessionWatcher')])}</g:link>
</li>
</ul>


</div>

