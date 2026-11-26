<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleTableDisplay('participantsSummaryZone');
    toggleTableDisplay('participantsDetailedZone');
    return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="session.show.participants"/>
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails"/></span>
    </div>

    <g:set var="currentUserParticipation" value="${sessionInstance.getParticipationOf(request.currentUser?.username)}"/>

    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="none"/>
        <g:set var="defaultDisplayForDetailedZone" value="table"/>
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
        <table id="participantsDetailedZone" class="zone-table" style="display: ${defaultDisplayForDetailedZone};">
            <tr>
                <td>
                    <g:set var="hidePendingPlayersByDefault" value="${true}" />
                    <div class="participants-layout">
                        <div class="participants-main">
                            <g:render template="participantsList" />
                        </div>
                        <aside class="participants-aside">
                            <h3><g:message code="options"/></h3>
                            <label class="option">
                                <g:checkBox name="hidePendingPlayers" value="${hidePendingPlayersByDefault}" checked="${hidePendingPlayersByDefault}"
                                            onclick="togglePendingParticipations(); return true; " />
                                <span><g:message code="session.show.participants.hidePendingPlayers"/></span>
                            </label>
                            <h3><g:message code="session.show.participants.legend"/></h3>
                            <g:render template="participantsLegend" />
                        </aside>
                    </div>
                </td>
            </tr>
            <g:if test="${sessionIsManagedByCurrentUser}">
                <tr>
                    <td>
                        <g:render template="participantsManagement" />
                    </td>
                </tr>
            </g:if>
        </table>
    </div>
</div>
