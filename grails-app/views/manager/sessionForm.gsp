<%@ page import="flexygames.Session" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="desktop" />
        <g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
        <g:if test="${params.create == '1'}">
        	<title><g:message code="management.session.add" /></title>
        </g:if>
        <g:else>
        	<title><g:message code="default.edit.label" args="[entityName]" /></title>
        </g:else>
    </head>
    <body>
        <div class="body">
	        <g:if test="${params.create == '1'}">
	        	<h1><g:message code="management.session.add" /></h1>
	        </g:if>
			<g:else>
            	<h1><g:message code="session.edit.title" /></h1>
            </g:else>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${sessionInstance}">
            <div class="errors">
                <g:renderErrors bean="${sessionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${sessionInstance?.id}" />
                <g:hiddenField name="version" value="${sessionInstance?.version}" />
                <g:hiddenField name="create" value="${params.create}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
							<g:if test="${params.create != '1'}">
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                  <g:message code="session.creation" default="Creation" />
	                                </td>
	                                <td valign="top" class="value">
	                                    <g:message code="session.creation.value" args="[sessionInstance.creation, sessionInstance.creator]" />
	                                </td>
	                                <td style="font-size: 12px">
	                                	<g:message code="session.creation.infos" />
	                                </td>
	                            </tr>
                            </g:if>

                            <g:if test="${sessionInstance.lastUpdater}">
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <g:message code="session.update" default="Update" />
                                    </td>
                                    <td valign="top" class="value">
                                        <g:message code="session.update.value" args="[sessionInstance.lastUpdate, sessionInstance.lastUpdater]" />
                                    </td>
                                    <td style="font-size: 12px">
                                        <g:message code="session.update.infos" />
                                    </td>
                                </tr>
                            </g:if>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><nobr><g:message code="session.type" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'type', 'errors')}">
                                    <g:select id="type" name="type.id" from="${flexygames.GameType.list()}" optionKey="id" required="" value="${sessionInstance?.type?.id}" class="many-to-one"/>
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.type.infos" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="group"><nobr><g:message code="session.group" default="Group" /> <font color="red">*</font></nobr></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'group', 'errors')}">
									<g:select name="group.id" from="${sessionInstance.group.defaultTeams.first().sessionGroups}"
										optionKey="id" value="${sessionInstance.group.id}" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.group.infos" />
                                </td>
                            </tr>
                            
                            <g:if test="${sessionInstance?.group.competition}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="session.name" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${sessionInstance?.name}" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.name.infos" />
                                </td>
                            </tr>
                        	</g:if>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="session.description" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" maxlength="100" value="${sessionInstance?.description}" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.description.infos" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date"><nobr><g:message code="session.date" default="Date" /> <font color="red">*</font></nobr></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'date', 'errors')}">
                                    <g:datePicker name="date" precision="minute" value="${sessionInstance?.date}" years="${2011..2021}"  />
                                    <!--calendar:resources lang="en" theme="green"/-->
                                    <!--calendar:datePicker name="date" defaultValue="${sessionInstance?.date}" showTime="true" dateFormat="%Y/%m/%d %H:%M" /-->
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.date.infos" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="duration"><nobr><g:message code="session.duration" default="Duration" /></nobr></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'duration', 'errors')}">
                                    <g:field type="number" name="duration" min="1" size="2" value="${fieldValue(bean: sessionInstance, field: 'duration')}"/>
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.duration.infos" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="rdvBeforeStart"><nobr><g:message code="session.rdvBeforeStart" default="rdvBeforeStart" /></nobr></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'rdvBeforeStart', 'errors')}">
                                    <g:field type="number" name="rdvBeforeStart" min="0" value="${fieldValue(bean: sessionInstance, field: 'rdvBeforeStart')}"/>
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.rdvBeforeStart.infos" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="playground"><nobr><g:message code="session.playground" default="Playground" /> <font color="red">*</font></nobr></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'playground', 'errors')}">
                                    <g:select name="playground.id" from="${flexygames.Playground.list(sort: 'name')}" optionKey="id" value="${sessionInstance?.playground?.id}"  />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.playground.infos" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="imageUrl"><g:message code="session.imageUrl" default="Image URL" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'imageUrl', 'errors')}">
									<g:field type="url" name="imageUrl" value="${sessionInstance?.imageUrl}"/>
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.imageUrl.infos" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="galleryUrl"><g:message code="session.galleryUrl" default="Gallery URL" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'galleryUrl', 'errors')}">
									<g:field type="url" name="galleryUrl" value="${sessionInstance?.galleryUrl}"/>
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.galleryUrl.infos" />
                                </td>
                            </tr>

                        <!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="extraFieldName"><g:message code="session.extraFieldName" default="Extra field name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'extraFieldName', 'errors')}">
									<g:textField name="extraFieldName" value="${sessionInstance?.extraFieldName}" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.extraFieldName.infos" />
                                </td>
                            </tr>
                            
							<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="extraFieldValue"><g:message code="session.extraFieldValue" default="Extra field value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'extraFieldValue', 'errors')}">
									<g:textField name="extraFieldValue" value="${sessionInstance?.extraFieldValue}" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.extraFieldValue.infos" />
                                </td>
                            </tr>
                            -->
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tasks"><g:message code="session.tasks" default="Tasks" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'tasks', 'errors')}">
                                    <g:if test="${sessionInstance?.tasks?.size() > 0}">
                                        <ul>
                                            <g:each in="${sessionInstance.tasks}" var="task" >
                                                <li>
                                                    <b><g:message code="task.${task.type.code}" /></b>
                                                    <g:link controller="player" action="show" id="${task.user.id}" >${task.user}</g:link>
                                                    <g:link controller="manager" action="deleteTask" id="${task.id}" >
                                                        <img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
                                                    </g:link>
                                                </li>
                                            </g:each>
                                        </ul>
                                    </g:if>
                                    <g:else>
                                        <i><g:message code="session.tasks.nothing" /></i>
                                        <br />
                                    </g:else>
                                    <br />
                                    <g:message code="session.tasks.add" />:
                                    <br />
                                    <g:select name="taskTypeId" from="${flexygames.TaskType.list()}"
                                              optionKey="id" optionValue="code" valueMessagePrefix="task" noSelection="['': '']"/>
                                    <g:message code="to" />
                                    <g:select name="taskUserId"
                                              from="${sessionInstance.group.defaultTeams.first().members}"
                                              optionKey="id" noSelection="['': '']"/>
                                </td>
                                <td style="font-size: 12px">
                                    <g:message code="session.tasks.infos" />
                                </td>
                            </tr>

							<g:if test="${params.create != '1'}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reminders"><g:message code="session.reminders" default="Reminders" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sessionInstance, field: 'reminders', 'errors')}">
                                	<g:if test="${sessionInstance?.reminders?.size() > 0}">
	                                	<ul>
	                                		<g:each in="${sessionInstance?.reminders}" var="reminder">
	                                			<li>
	                                				<b>${reminder.minutesBeforeSession / 60}  <g:message code="hours" /></b> 
	                                				<g:message code="session.reminders.beforeStart" />
	                                				<g:link controller="manager" action="deleteReminder" id="${reminder.id}" >
	                                					<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
	                                				</g:link>
	                                			</li>
	                                		</g:each>
	                                	</ul>
                                	</g:if>
                                	<g:else>
                                		<i><g:message code="session.reminders.nothing" /></i>
                                	</g:else>
                                	<br />
                                	<g:message code="session.reminders.add" />
                                	<g:field type="number" name="minutesForNewReminder" value="" size="4" />
                                </td>
                                <td style="font-size: 12px">
                                	<g:message code="session.reminders.infos" />
                                </td>
                            </tr>
                            </g:if>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                	<g:if test="${params.create == '1'}">
                		<span class="button"><g:actionSubmit class="create" action="addSession" value="${message(code: 'add')}" /></span>
                	</g:if>
                	<g:else>
                    	<span class="button"><g:actionSubmit class="save" action="updateSession" value="${message(code: 'update')}" /></span>
                    	<span class="button"><g:actionSubmit class="delete" onclick="return confirm('${message(code:'management.session.areYouSureToDelete')}')" action="deleteSession" value="${message(code:'management.session.delete')}" /></span>
                    </g:else>
                </div>
            </g:form>
        </div>
    </body>
</html>
