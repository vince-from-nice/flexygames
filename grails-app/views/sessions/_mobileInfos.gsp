<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleDisplay('infosSummaryZone'); toggleDisplay('infosDetailedZone'); return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="informations" />
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
    </div>
    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="none" />
        <g:set var="defaultDisplayForDetailedZone" value="block" />
        <div id="infosSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
        </div>
        <div id="infosDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
            <table>
                <tr>
                    <td>
                        <g:message code="session.show.date"/>:
                        <b><g:formatDate date="${sessionInstance?.date}" format="EEEE dd MMMM yyyy"/></b>
                        <br>
                        <ul>
                            <li><g:message code="session.show.date.locking" />: <b><g:formatDate date="${sessionInstance.lockingDate}" format="HH:mm"/></b></li>
                            <li><g:message code="session.show.date.rdv" />: <b><g:formatDate date="${sessionInstance.rdvDate}" format="HH:mm"/></b></li>
                            <li><g:message code="session.show.date.start" />: <b><g:formatDate date="${sessionInstance?.date}" format="HH:mm"/></b></li>
                            <li><g:message code="session.show.date.end" />: <b><g:formatDate date="${sessionInstance.endDate}" format="HH:mm"/></b></li>
                        </ul>
                        <g:message code="playground" default="Playground" />:
                        <g:link controller="playground" action="show" id="${sessionInstance?.playground?.id}" onclick="toggleDisplay('playgroundDiv'); return false" >
                            ${sessionInstance?.playground?.encodeAsHTML()}
                        </g:link>
                        <div id="playgroundDiv" class="block" style="display: none;">
                            ${sessionInstance?.playground?.postalAddress}
                            <g:if test="${sessionInstance?.playground?.gmapsUrl}">
                                <br>
                                <g:message code="phoneNumber" /> : ${sessionInstance?.playground?.phoneNumber}
                            </g:if>
                            <br>
                            <g:link controller="playgrounds" action="show" id="${sessionInstance?.playground?.id}"><g:message code="session.show.viewPlayground" /></g:link>
                        </div>
                        <br>
                        <br>
                        <g:if test="${sessionInstance.description}">
                            <g:message code="session.description" default="Description" />:
                            ${fieldValue(bean: sessionInstance, field: "description")}
                            <br>
                        </g:if>
                        <g:message code="group" default="Group" />:
                        <g:link controller="sessions" action="list" params="${['filteredSessionGroup':sessionInstance.group.id]}" >
                            ${sessionInstance?.group?.encodeAsHTML()}
                        </g:link>
                        <g:if test="${sessionInstance.tasks.size() > 0}">
                            <g:set var="lastTaskType" />
                            <g:each in="${sessionInstance.tasks}" var="task" >
                                <g:if test="${task.type != lastTaskType}">
                                    <g:if test="${lastTaskType}">
                                        <br>
                                    </g:if>
                                    <g:message code="task.${task.type.code}" />
                                    <g:link controller="player" action="show" id="${task.user.id}" >${task.user}</g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="player" action="show" id="${task.user.id}" >${task.user}</g:link>
                                </g:else>
                                <g:set var="lastTaskType" value="${task.type}" />
                            </g:each>
                        </g:if>
                    </td>
                    <td style="text-align: center; ">
                        <g:set var="defaultFirstTeam" value="${sessionInstance.group.defaultTeams?.first()}" scope="request" />
                        <g:message code="session.show.relatedTeams" />:
                        <br />
                        <g:link controller="teams" action="show" id="${defaultFirstTeam.id}">
                            <g:if test="${defaultFirstTeam?.logoName}">
                                <img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:defaultFirstTeam.logoName)}" alt="Team logo" />
                            </g:if>
                            <g:else>
                                <img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:'no-logo.png')}" alt="Team logo" />
                            </g:else><br />
                            ${defaultFirstTeam}
                        </g:link>
                        <br>
                    </td>
                </tr>
            </table>
            <g:if test="${sessionIsManagedByCurrentUser}">
                <span style="width: 100%	">
                    <g:form controller="manager">
                        <g:hiddenField name="id" value="${sessionInstance?.id}" />
                        <div class="buttons">
                            <g:actionSubmit class="edit" action="editSession" value="${message(code:'management.session.edit')}" />
                            <g:actionSubmit class="create" action="duplicateSession" value="${message(code:'management.session.duplicate')}" onclick="toggleDisplay('duplicationForm'); return false; " />
                            <g:if test="${!sessionInstance.canceled}">
                                <g:actionSubmit class="delete" action="deleteSession" value="${message(code:'management.session.cancel')}" onclick="toggleDisplay('cancelationForm'); return false; " />
                                <!--span style="color: red;"><= NEW !!</span-->
                            </g:if>
                        </div>
                        <div id="duplicationForm" style="display: none; ">
                            <br>
                            <g:message code="management.session.duplicationOffset" />:
                            <g:field type="number" name="duplicationOffset" value="7" size="2" style="width: 3em;" />
                            <g:actionSubmit class="create" value="Ok" action="duplicateSession" />
                        </div>
                        <div id="cancelationForm" style="display: none; ">
                            <br>
                            <g:message code="management.session.cancelInfos" />:
                            <br>
                            <g:textArea name="cancelationLog" style="width: 80%;"></g:textArea>
                            <g:actionSubmit class="delete" value="Ok" action="cancelSession" />
                        </div>
                    </g:form>
                </span>
            </g:if>
        </div>
    </div>
</div>


