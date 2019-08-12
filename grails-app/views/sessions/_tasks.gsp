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
        <g:set var="isBallTaskAssigned" value="${false}"/>
        <g:set var="isJerseyTaskAssigned" value="${false}"/>
        <table id="tasksDetailedZone" style="display: ${defaultDisplayForDetailedZone}; border: none; margin: 0px">
            <g:if test="${tasksByTypeCode.size() > 0}" >
                <g:each in="${tasksByTypeCode}" var="tasksByTypeCodeElement">
                    <tr>
                        <td>
                            <g:message code="task.type.${tasksByTypeCodeElement.key}"/>
                            &nbsp;&nbsp;&nbsp;
                            <g:each in="${tasksByTypeCodeElement.value}" var="task">
                                <g:if test="${tasksByTypeCodeElement.key == 'BALLS'}"><g:set var="isBallTaskAssigned" value="${true}"/></g:if>
                                <g:if test="${tasksByTypeCodeElement.key == 'JERSEY'}"><g:set var="isJerseyTaskAssigned" value="${true}"/></g:if>
                                <span>
                                    <g:render template="/common/avatar" model="[player:task.user]" />
                                    <g:set var="username" value="${task.user.username}" />
                                    <g:if test="${username.length() > 8}">
                                        <g:set var="username" value="${username.substring(0, 7)}.." />
                                    </g:if>
                                    <g:link controller="player" action="show" id="${task.user.id}" >${username}</g:link>
                                    <g:if test="${task.user == request.currentUser || sessionIsManagedByCurrentUser}">
                                        <g:link action="deleteTask" id="${task.id}" >
                                            <img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
                                        </g:link>
                                    </g:if>
                                </span>
                                &nbsp;&nbsp;&nbsp;
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
            <g:if test="${sessionInstance.date.time > java.lang.System.currentTimeMillis()}">
                <g:if test="${sessionInstance.group.ballsTaskNeeded && !isBallTaskAssigned}">
                    <tr>
                        <td>
                            <g:if test="${sessionInstance.date.time < java.lang.System.currentTimeMillis() + 1000 * 60 * 60 * 24}">
                                <span style="color: red; text-decoration: blink; font-weight: bold;"><g:message code="session.show.tasks.ballsNotAssigned"/></span>
                            </g:if>
                            <g:else>
                                <span style="color: orange;"><g:message code="session.show.tasks.ballsNotAssigned"/></span>
                            </g:else>
                            <br />
                        </td>
                    </tr>
                </g:if>
                <g:if test="${sessionInstance.group.jerseyTaskNeeded && !isJerseyTaskAssigned}">
                    <tr>
                        <td>
                            <g:if test="${sessionInstance.date.time < java.lang.System.currentTimeMillis() + 1000 * 60 * 60 * 24}">
                                <span style="color: red; text-decoration: blink; font-weight: bold;"><g:message code="session.show.tasks.jerseyNotAssigned"/></span>
                            </g:if>
                            <g:else>
                                <span style="color: orange;"><g:message code="session.show.tasks.jerseyNotAssigned"/></span>
                            </g:else>
                            <br />
                        </td>
                    </tr>
                </g:if>
            </g:if>
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