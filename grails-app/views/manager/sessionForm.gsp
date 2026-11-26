<%@ page import="flexygames.Session" %>
<html>
<head>
	<meta name="layout" content="modern" />
	<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
	<g:if test="${params.create == '1'}">
		<title><g:message code="management.session.add" /></title>
	</g:if>
	<g:else>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</g:else>
</head>
<body>
	<div class="card form-card form-wide">
		<g:if test="${params.create == '1'}">
			<h1><g:message code="management.session.add" /></h1>
		</g:if>
		<g:else>
			<h1><g:message code="session.edit.title" /></h1>
		</g:else>
		<g:if test="${params.create != '1' && sessionInstance.creation}">
			<p class="field-help" title="${message(code: 'session.creation.infos')}">
				<g:message code="session.creation" default="Creation" /> :
				<g:message code="session.creation.value" args="[sessionInstance.creation, sessionInstance.creator]" />
			</p>
		</g:if>
		<g:if test="${sessionInstance.lastUpdater}">
			<p class="field-help" title="${message(code: 'session.update.infos')}">
				<g:message code="session.update" default="Update" /> :
				<g:message code="session.update.value" args="[sessionInstance.lastUpdate, sessionInstance.lastUpdater]" />
			</p>
		</g:if>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${sessionInstance}">
			<div class="errors">
				<g:renderErrors bean="${sessionInstance}" as="list" />
			</div>
		</g:hasErrors>

		<g:form method="post">
			<g:hiddenField name="id" value="${sessionInstance?.id}" />
			<g:hiddenField name="version" value="${sessionInstance?.version}" />
			<g:hiddenField name="create" value="${params.create}" />

			<fieldset class="form-section">
				<div class="field-row">
					<div class="field ${hasErrors(bean: sessionInstance, field: 'type', 'error')}">
						<label for="type"><g:message code="session.type" default="Type" /></label>
						<g:select id="type" name="type.id" from="${flexygames.GameType.list()}" optionKey="id" required="" value="${sessionInstance?.type?.id}" class="many-to-one"/>
						<p class="field-help"><g:message code="session.type.infos" /></p>
					</div>
					<div class="field ${hasErrors(bean: sessionInstance, field: 'group', 'error')}">
						<label for="group.id"><g:message code="session.group" default="Group" /> <span class="required-mark">*</span></label>
						<g:select id="group.id" name="group.id" from="${sessionInstance.group.defaultTeams.first().sessionGroups}" optionKey="id" value="${sessionInstance.group.id}" />
						<p class="field-help"><g:message code="session.group.infos" /></p>
					</div>
				</div>
				<g:if test="${sessionInstance?.group.competition}">
					<div class="field ${hasErrors(bean: sessionInstance, field: 'name', 'error')}">
						<label for="name"><g:message code="session.name" default="Name" /></label>
						<g:textField name="name" value="${sessionInstance?.name}" />
						<p class="field-help"><g:message code="session.name.infos" /></p>
					</div>
				</g:if>
				<div class="field ${hasErrors(bean: sessionInstance, field: 'description', 'error')}">
					<label for="description"><g:message code="session.description" default="Description" /></label>
					<g:textField name="description" maxlength="100" value="${sessionInstance?.description}" />
					<p class="field-help"><g:message code="session.description.infos" /></p>
				</div>
			</fieldset>

			<fieldset class="form-section">
				<div class="field ${hasErrors(bean: sessionInstance, field: 'date', 'error')}">
					<span class="field-label"><g:message code="session.date" default="Date" /> <span class="required-mark">*</span></span>
					<div class="date-picker">
						<g:datePicker name="date" precision="minute" value="${sessionInstance?.date}" years="${2011..2031}" />
					</div>
					<p class="field-help"><g:message code="session.date.infos" /></p>
				</div>
				<div class="field-row">
					<div class="field field-short ${hasErrors(bean: sessionInstance, field: 'duration', 'error')}">
						<label for="duration"><g:message code="session.duration" default="Duration" /></label>
						<g:field type="number" name="duration" min="1" value="${fieldValue(bean: sessionInstance, field: 'duration')}"/>
						<p class="field-help"><g:message code="session.duration.infos" /></p>
					</div>
					<div class="field field-short ${hasErrors(bean: sessionInstance, field: 'rdvBeforeStart', 'error')}">
						<label for="rdvBeforeStart"><g:message code="session.rdvBeforeStart" default="rdvBeforeStart" /></label>
						<g:field type="number" name="rdvBeforeStart" min="0" value="${fieldValue(bean: sessionInstance, field: 'rdvBeforeStart')}"/>
						<p class="field-help"><g:message code="session.rdvBeforeStart.infos" /></p>
					</div>
					<div class="field field-short ${hasErrors(bean: sessionInstance, field: 'lockingTime', 'error')}">
						<label for="lockingTime"><g:message code="session.lockingTime" default="lockingTime" /></label>
						<g:field type="number" name="lockingTime" min="1" value="${fieldValue(bean: sessionInstance, field: 'lockingTime')}"/>
						<p class="field-help"><g:message code="session.lockingTime.infos" /></p>
					</div>
				</div>
				<div class="field ${hasErrors(bean: sessionInstance, field: 'playground', 'error')}">
					<label for="playground.id"><g:message code="session.playground" default="Playground" /> <span class="required-mark">*</span></label>
					<g:select id="playground.id" name="playground.id" from="${flexygames.Playground.list(sort: 'name')}" optionKey="id" value="${sessionInstance?.playground?.id}" />
					<p class="field-help"><g:message code="session.playground.infos" /></p>
				</div>
			</fieldset>

			<fieldset class="form-section">
				<div class="field-row">
					<div class="field ${hasErrors(bean: sessionInstance, field: 'imageUrl', 'error')}">
						<label for="imageUrl"><g:message code="session.imageUrl" default="Image URL" /></label>
						<g:field type="url" name="imageUrl" value="${sessionInstance?.imageUrl}"/>
						<p class="field-help"><g:message code="session.imageUrl.infos" /></p>
					</div>
					<div class="field ${hasErrors(bean: sessionInstance, field: 'galleryUrl', 'error')}">
						<label for="galleryUrl"><g:message code="session.galleryUrl" default="Gallery URL" /></label>
						<g:field type="url" name="galleryUrl" value="${sessionInstance?.galleryUrl}"/>
						<p class="field-help"><g:message code="session.galleryUrl.infos" /></p>
					</div>
				</div>
			</fieldset>

			<fieldset class="form-section">
				<legend><g:message code="session.tasks" default="Tasks" /></legend>
				<p class="field-help"><g:message code="session.tasks.infos" /></p>
				<g:if test="${sessionInstance?.tasks?.size() > 0}">
					<ul class="item-list">
						<g:each in="${sessionInstance.tasks}" var="task">
							<li>
								<strong><g:message code="${task.type.code}" /></strong>
								<g:link controller="player" action="show" id="${task.user.id}">${task.user}</g:link>
								<g:link controller="manager" action="deleteTask" id="${task.id}" class="item-delete">
									<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete" />
								</g:link>
							</li>
						</g:each>
					</ul>
				</g:if>
				<g:else>
					<p class="muted"><g:message code="session.tasks.nothing" /></p>
				</g:else>
				<div class="inline-row">
					<label for="taskTypeId"><g:message code="session.tasks.add" /></label>
					<g:select name="taskTypeId" from="${flexygames.TaskType.list()}" optionKey="id" optionValue="code" valueMessagePrefix="task" noSelection="['': '']"/>
					<label for="taskUserId"><g:message code="to" /></label>
					<g:select name="taskUserId" from="${sessionInstance.group.defaultTeams.first().members}" optionKey="id" noSelection="['': '']"/>
				</div>
			</fieldset>

			<g:if test="${params.create != '1'}">
				<fieldset class="form-section">
					<legend><g:message code="session.reminders" default="Reminders" /></legend>
					<p class="field-help"><g:message code="session.reminders.infos" /></p>
					<g:if test="${sessionInstance?.reminders?.size() > 0}">
						<ul class="item-list">
							<g:each in="${sessionInstance?.reminders}" var="reminder">
								<li>
									<strong>${reminder.minutesBeforeSession / 60} <g:message code="hours" /></strong>
									<g:message code="session.reminders.beforeStart" />
									<g:link controller="manager" action="deleteReminder" id="${reminder.id}" class="item-delete">
										<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete" />
									</g:link>
								</li>
							</g:each>
						</ul>
					</g:if>
					<g:else>
						<p class="muted"><g:message code="session.reminders.nothing" /></p>
					</g:else>
					<div class="field field-short">
						<label for="minutesForNewReminder"><g:message code="session.reminders.add" /></label>
						<g:field type="number" name="minutesForNewReminder" min="1" value="" />
					</div>
				</fieldset>
			</g:if>

			<div class="form-actions">
				<g:if test="${params.create == '1'}">
					<g:actionSubmit class="create" action="addSession" value="${message(code: 'add')}" />
				</g:if>
				<g:else>
					<g:actionSubmit class="save" action="updateSession" value="${message(code: 'update')}" />
					<g:actionSubmit class="delete" onclick="return confirm('${message(code:'management.session.areYouSureToDelete')}')" action="deleteSession" value="${message(code:'management.session.delete')}" />
				</g:else>
			</div>
		</g:form>
	</div>
</body>
</html>
