    <h3><g:message code="management.title"/></h3>
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
                                        style="width: 450px; height: 70px;"></g:textArea><br/>
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
