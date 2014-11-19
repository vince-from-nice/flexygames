<%@ page import="flexygames.Team" %>



<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="team.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${teamInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="team.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${teamInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'city', 'error')} ">
	<label for="city">
		<g:message code="team.city.label" default="City" />
		
	</label>
	<g:textField name="city" value="${teamInstance?.city}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'webUrl', 'error')} ">
	<label for="webUrl">
		<g:message code="team.webUrl.label" default="Web Url" />
		
	</label>
	<g:field type="url" name="webUrl" value="${teamInstance?.webUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="team.email.label" default="Email" />
		
	</label>
	<g:field type="email" name="email" value="${teamInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'logo', 'error')} ">
	<label for="logo">
		<g:message code="team.logo.label" default="Logo" />
		
	</label>
	<g:select id="logo" name="logo.id" from="${com.lucastex.grails.fileuploader.UFile.list()}" optionKey="id" value="${teamInstance?.logo?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'memberships', 'error')} ">
	<label for="memberships">
		<g:message code="team.memberships.label" default="Memberships" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${teamInstance?.memberships?}" var="m">
    <li><g:link controller="membership" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="membership" action="create" params="['team.id': teamInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'membership.label', default: 'Membership')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'sessionGroups', 'error')} ">
	<label for="sessionGroups">
		<g:message code="team.sessionGroups.label" default="Session Groups" />
		
	</label>
	<g:select name="sessionGroups" from="${flexygames.SessionGroup.list()}" multiple="multiple" optionKey="id" size="5" value="${teamInstance?.sessionGroups*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamInstance, field: 'defaultSessionGroup', 'error')} required">
	<label for="defaultSessionGroup">
		<g:message code="team.defaultSessionGroup.label" default="Default Session Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="defaultSessionGroup" name="defaultSessionGroup.id" from="${flexygames.SessionGroup.list()}" optionKey="id" required="" value="${teamInstance?.defaultSessionGroup?.id}" class="many-to-one"/>
</div>

