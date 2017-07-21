<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleDisplay('tasksSummaryZone'); toggleTableDisplay('tasksDetailedZone'); return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="session.show.tasks" />
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
    </div>
    <g:set var="defaultDisplayForSummaryZone" value="block" />
    <g:set var="defaultDisplayForDetailedZone" value="none" />
    <g:if test="${sessionInstance.tasks.size() + 1 > 0}">
        <g:set var="defaultDisplayForSummaryZone" value="none" />
        <g:set var="defaultDisplayForDetailedZone" value="table" />
    </g:if>
    <div class="sessionZoneContent">
        <div id="tasksSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
            <g:if test="${sessionInstance.tasks.size() > 0}" >
                <g:message code="session.show.tasks.tasksNbr"/> : <b>${sessionInstance.tasks.size()}</b>
            </g:if>
            <g:else>
                <g:message code="session.show.tasks.noTask"/>
            </g:else>
        </div>
        <table id="tasksDetailedZone" style="display: ${defaultDisplayForDetailedZone}; border: none; margin: 0px">
            <g:if test="${tasksByTypeCode.size() > 0}" >
                <g:each in="${tasksByTypeCode}" var="tasksByTypeCodeElement">
                    <tr>
                        <td>
                            <g:message code="task.type.${tasksByTypeCodeElement.key}"/>
                            <g:each in="${tasksByTypeCodeElement.value}" var="task">
                                <g:link controller="player" action="show" id="${task.user.id}" >${task.user.username}</g:link>
                                <g:if test="${task.user == session.currentUser}">
                                    <g:link action="deleteTask" id="${task.id}" >
                                        <img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
                                    </g:link>
                                </g:if>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <tr>
                    <td>
                        <i><g:message code="session.show.tasks.noTask"/></i>
                        <br />
                    </td>
                </tr>
            </g:else>
            <tr>
                <td style="background-color: #d8f3f0">
                    <g:form name="taskForm" action="addTask" id="${sessionInstance.id}">
                        <g:message code="session.show.tasks.wantToHelp"/>:
                        <g:select name="newTaskCode" from="${flexygames.TaskType.list()}" optionKey="code" valueMessagePrefix="session.show.tasks.new"/>
                        <g:submitButton name="newTask" value="OK"/>
                    </g:form>
                </td>
            </tr>
        </table>
    </div>
</div>
<g:set scope="request" var="timeAfterTasks" value="${java.lang.System.currentTimeMillis()}" />