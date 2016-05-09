<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleTableDisplay('participantsSummaryZone');
    toggleTableDisplay('participantsDetailedZone');
    return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="session.show.participants"/>
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForDetails"/></span>
    </div>

    <g:set var="currentUserParticipation" value="${sessionInstance.getParticipationOf(session.currentUser?.username)}"/>

    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="table"/>
        <g:set var="defaultDisplayForDetailedZone" value="none"/>
        <g:if test="${sessionIsManagedByCurrentUser || currentUserParticipation?.statusCode == flexygames.Participation.Status.REQUESTED.code()}">
            <g:set var="defaultDisplayForSummaryZone" value="none"/>
            <g:set var="defaultDisplayForDetailedZone" value="table"/>
        </g:if>
        <table class="fuckCSS" id="participantsSummaryZone"
               style="display: ${defaultDisplayForSummaryZone}; width: 100%; ">
            <tr>
                <td colspan="6" style="text-align: center; width: 100%; ">
                    <g:if test="${currentUserParticipation}">
                        <div style="text-align: center; vertical-align: middle; border: solid black 1px;
                        background-color: ${flexygames.Participation.Status.color(currentUserParticipation.statusCode)}; ">
                            &nbsp;<br>
                            <g:message code="session.show.participants.youHaveAlreadyJoined"
                                       args="[message(code: 'participation.status.' + currentUserParticipation.statusCode), currentUserParticipation.lastUpdater, grailsApplication.mainContext.getBean('flexygames.FlexyTagLib').formatDate(currentUserParticipation.lastUpdate.time, true)]"/>
                            <br>&nbsp;
                        </div>
                    </g:if>
                    <g:else>
                        <g:message code="session.show.participants.youHaveNotJoined"/>
                        <g:form controller="sessions" action="join">
                            <g:hiddenField name="id" value="${sessionInstance?.id}"/>
                            <g:actionSubmit class="create"
                                            onclick="return confirm('${message(code: 'session.show.participants.join.alert')}');"
                                            action="join" value="${message(code: 'session.show.participants.join')}"/>
                        </g:form>
                    </g:else>
                </td>
            </tr>
            <g:render template="counter" model="[]"/>
        </table>
        <table id="participantsDetailedZone"
               style="border: 0px; display: ${defaultDisplayForDetailedZone}; width: 100%">
            <tr>
                <td>
                    <g:set var="hidePendingPlayersByDefault" value="${true}" />
                    <g:if test="${sessionIsManagedByCurrentUser}">
                        <g:set var="hidePendingPlayersByDefault" value="${true}" />
                    </g:if>
                    <g:render template="participantsList" />
                </td>
                <td style="width: 100px;">
                    <h3><g:message code="options"/></h3>
                    <g:checkBox name="hidePendingPlayers" value="${hidePendingPlayersByDefault}" checked="${hidePendingPlayersByDefault}"
                                onclick="togglePendingParticipations(); return true; " />
                    <g:message code="session.show.participants.hidePendingPlayers"/>
                    <br/>
                    <br/>
                    <h3><g:message code="session.show.participants.legend"/></h3>
                    <g:render template="participantsLegend" />
                </td>
            </tr>
            <g:if test="${sessionIsManagedByCurrentUser}">
                <tr>
                    <td colspan="2">
                        <g:render template="participantsManagement" />
                    </td>
                </tr>
            </g:if>
        </table>
    </div>
</div>
