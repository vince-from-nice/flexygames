<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleTableDisplay('participantsSummaryZone');
    toggleDisplay('participantsDetailedZone');
    return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="session.show.participants"/>
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails"/></span>
    </div>

    <g:set var="currentUserParticipation" value="${sessionInstance.getParticipationOf(session.currentUser?.username)}"/>

    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="table"/>
        <g:set var="defaultDisplayForDetailedZone" value="none"/>
        <!-- Display the participants table by default if user is in pending status or can manage the session -->
        <g:if test="${sessionIsManagedByCurrentUser || currentUserParticipation?.statusCode == flexygames.Participation.Status.REQUESTED.code()}">
            <g:set var="defaultDisplayForSummaryZone" value="none"/>
            <g:set var="defaultDisplayForDetailedZone" value="block"/>
        </g:if>
        <table class="fuckCSS" id="participantsSummaryZone"
               style="display: ${defaultDisplayForSummaryZone}; width: 100%; ">
            <tr>
                <td colspan="6" style="text-align: center; font-size: x-large; width: 100%; ">
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
        <div id="participantsDetailedZone" style="border: 0px; display: ${defaultDisplayForDetailedZone}; width: 100%">
            <g:set var="hidePendingPlayersByDefault" value="${true}" />
            <g:if test="${sessionIsManagedByCurrentUser}">
                <g:set var="hidePendingPlayersByDefault" value="${true}" />
            </g:if>
            <g:render template="participantsList" />
            <form>
                <input type="checkbox" data-role="flipswitch" name="hidePendingPlayers" id="flip-checkbox-4" checked="${hidePendingPlayersByDefault}" onchange="togglePendingParticipations(); return true; ">
                <label for="hidePendingPlayers" style="display: inline;"><g:message code="session.show.participants.hidePendingPlayers"/></label>
            </form>
            <!--g:checkBox name="hidePendingPlayers" value="${hidePendingPlayersByDefault}" checked="${hidePendingPlayersByDefault}"
                        onclick="togglePendingParticipations(); return true; " />
            <div style="position: relative; left: 40px; top: -15px"><g:message code="session.show.participants.hidePendingPlayers"/></div-->
            <g:if test="${sessionIsManagedByCurrentUser}">
                <g:render template="participantsManagement" />
            </g:if>
        </div>
    </div>
</div>
