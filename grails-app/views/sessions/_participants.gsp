<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleTableDisplay('participantsSummaryZone');
    toggleTableDisplay('participantsDetailedZone');
    return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="session.show.participants"/>
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForDetails"/></span>
    </div>

    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="table"/>
        <g:set var="defaultDisplayForDetailedZone" value="none"/>
        <g:if test="${sessionIsManagedByCurrentUser}">
            <g:set var="defaultDisplayForSummaryZone" value="none"/>
            <g:set var="defaultDisplayForDetailedZone" value="table"/>
        </g:if>
        <table class="fuckCSS" id="participantsSummaryZone"
               style="display: ${defaultDisplayForSummaryZone}; width: 100%; ">
            <tr>
                <td colspan="6" style="text-align: center; width: 100%; ">
                    <g:set var="currentUserParticipation"
                           value="${sessionInstance.getParticipationOf(session.currentUser?.username)}"/>
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
                    <g:javascript>
                        function togglePendingParticipations() {
                            for (var i = 0; i < pendingParticipationIds.length; i++) {
                                var id = pendingParticipationIds[i];
                                //console.log('toggling participation-' + id);
                                var player = document.getElementById('participation-' + id);
                                if (player.style.display == 'table-row') {
                                    player.style.display = 'none';
                                } else {
                                    player.style.display = 'table-row';
                                }
                            }
                        }
                    </g:javascript>
                    <h3><g:message code="options"/></h3>
                    <g:checkBox name="hidePendingPlayers" value="${hidePendingPlayersByDefault}" checked="${hidePendingPlayersByDefault}"
                                onclick="togglePendingParticipations(); return true; "/>
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
                    <!--h3><g:message code="management.title"/></h3-->
                        <g:form controller="manager">
                            <g:hiddenField name="id" value="${sessionInstance?.id}"/>
                            <g:hiddenField name="messageType" value="email"/>
                            <div class="buttons">
                                <g:actionSubmit class="create" action="requestAllRegulars"
                                                value="${message(code: 'management.participations.requestAllRegulars')}"/>
                                <g:actionSubmit class="create" action="requestAllTourists"
                                                value="${message(code: 'management.participations.requestAllTourists')}"/>
                                <br/>
                                <g:actionSubmit class="create"
                                                onclick="toggleDisplay('extraInternalUserDiv'); return false"
                                                value="${message(code: 'management.participations.requestInternalPlayer')}"/>
                                <g:actionSubmit class="create"
                                                onclick="toggleDisplay('extraExternalUserDiv'); return false"
                                                value="${message(code: 'management.participations.requestExternalPlayer')}"/>
                                <div id="extraExternalUserDiv" style="display: none">
                                    <br/>
                                    <g:select name="externalUserId"
                                              from="${flexygames.User.list(sort: 'username', order: 'asc')}"
                                              optionKey="id" noSelection="['': '']"/>
                                    <g:actionSubmit class="create" action="requestExtraPlayer"
                                                    value="Invite that FlexyGames user !!"/>
                                </div>

                                <div id="extraInternalUserDiv" style="display: none">
                                    <br/>
                                    <g:select name="internalUserId"
                                              from="${sessionInstance.group.defaultTeams.first().members}"
                                              optionKey="id" noSelection="['': '']"/>
                                    <g:actionSubmit class="create" action="requestExtraPlayer"
                                                    value="Invite that team player !!"/>
                                </div>
                                <br/>
                                <g:actionSubmit class="edit"
                                                onclick="toggleDisplay('customizedMessageDiv'); return false"
                                                value="${message(code: 'management.participations.sendCustomizedMessage')}"/>
                                <g:actionSubmit class="edit"
                                                onclick="return confirm('${message(code: 'management.participations.areYouSureToSendGoGoGo')}')"
                                                action="sendGoGoGoMessage"
                                                value="${message(code: 'management.participations.sendGoGoGoMessage')}"/>
                                <br/>

                                <div id="customizedMessageDiv" style="display: none">
                                    <table style="width: auto">
                                        <tr>
                                            <%--
                                            <td>
                                                <input type="radio" name="messageType" value="email" checked>Email<br />
                                                <input type="radio" name="messageType" value="sms">SMS<br />
                                                <input type="radio" name="messageType" value="email+sms">Email + SMS<br />
                                            </td>
                                            --%>
                                            <td>
                                                <input type="radio" name="recipients" value="ONE_PARTICIPANT"
                                                       checked><g:message
                                                    code="management.participations.sendToSpecificParticipant"/> :
                                            &nbsp;&nbsp;&nbsp;<g:select name="recipientId"
                                                                        from="${sessionInstance.participations*.player}"
                                                                        optionKey="id"/><br/>
                                                <input type="radio" name="recipients"
                                                       value="AVAILABLE_PARTICIPANTS"><g:message
                                                    code="management.participations.sendToAllParticipantsAvailable"/><br/>
                                                <input type="radio" name="recipients"
                                                       value="ALL_PARTICIPANTS"><g:message
                                                    code="management.participations.sendToAllParticipants"/>
                                            </td>
                                            <td>
                                                <g:textArea name="message" rows="2" cols="40"
                                                            style="width: 450px; height: 70px;">Enter a customized message here..</g:textArea><br/>
                                            </td>
                                            <td style="vertical-align: middle;">
                                                <g:actionSubmit class="save" action="sendMessage"
                                                                value="Send message !!"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <g:actionSubmit class="save" action="approveAvailableParticipants"
                                                value="${message(code: 'management.participations.approveAvailableParticipants')}"/>
                                <g:actionSubmit class="save" action="validateApprovedParticipants"
                                                value="${message(code: 'management.participations.validateApprovedParticipants')}"/>
                            </div>
                        </g:form>
                    </td>
                </tr>
            </g:if>
        </table>
    </div>
</div>
