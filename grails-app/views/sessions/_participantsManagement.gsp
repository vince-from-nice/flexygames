<%@ page import="flexygames.Participation" %>
<h3><g:message code="management.title"/></h3>
    <g:form name="managementForm"  controller="manager">
        <g:hiddenField name="id" value="${sessionInstance?.id}"/>
        <g:hiddenField name="messageType" value="email"/>
        <div class="management">

            <b><g:message code="management.participations.invite"/></b>
            <br>
            <g:actionSubmit class="create"
                            onclick="toggleDisplay('extraInternalUserDiv'); return false"
                            value="${message(code: 'management.participations.requestInternalPlayer')}"/>
            <!--g:actionSubmit class="create"
                            onclick="toggleDisplay('extraExternalUserDiv'); return false"
                            value="${message(code: 'management.participations.requestExternalPlayer')}"/-->
            <!--br/-->
            <g:actionSubmit class="create" action="requestAllRegulars"
                            value="${message(code: 'management.participations.requestAllRegulars')}"/>
            <g:actionSubmit class="create" action="requestAllTourists"
                            value="${message(code: 'management.participations.requestAllTourists')}"/>
            <div id="extraExternalUserDiv" style="display: none">
                <br/>
                <!--g:select name="externalUserId"
                          from="${flexygames.User.list(sort: 'username', order: 'asc')}"
                          optionKey="id" noSelection="['': '']"/-->
                <g:actionSubmit class="create" action="requestExtraPlayer"
                                value="Invite that FlexyGames user !!"/>
            </div>
            <div id="extraInternalUserDiv" style="display: none">
                <br/>
                <g:select name="internalUserId"
                          from="${sessionInstance.group.defaultTeams.first().members}"
                          optionKey="id" noSelection="['': '']" aria-label="${message(code: 'player')}"/>
                <g:actionSubmit class="create" action="requestExtraPlayer"
                                value="Invite that team player !!"/>
            </div>
            <br/>

            <b><g:message code="management.participations.send"/></b>
            <br>
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
                            <label class="check-row"><input type="radio" name="recipients" value="ONE_PARTICIPANT" checked> <g:message code="management.participations.sendToSpecificParticipant"/></label>
                            <g:select name="recipientId" from="${sessionInstance.participations*.player}" optionKey="id" aria-label="${message(code: 'player')}"/>
                            <label class="check-row"><input type="radio" name="recipients" value="AVAILABLE_PARTICIPANTS"> <g:message code="management.participations.sendToAllParticipantsAvailable"/></label>
                            <label class="check-row"><input type="radio" name="recipients" value="ALL_PARTICIPANTS"> <g:message code="management.participations.sendToAllParticipants"/></label>
                        </td>
                        <td>
                            <g:textArea name="message" rows="3" aria-label="${message(code: 'management.participations.sendCustomizedMessage')}"></g:textArea>
                        </td>
                        <td style="vertical-align: middle;">
                            <g:actionSubmit class="save" action="sendMessage"
                                            value="Send message !!"/>
                        </td>
                    </tr>
                </table>
            </div>

            <b><g:message code="management.participations.update"/></b>
            <br>
            <g:message code="management.participations.quickUpdate"/>:
            <g:actionSubmit class="save" action="approveAvailableParticipants"
                            value="${message(code: 'management.participations.approveAvailableParticipants')}"/>
            <g:actionSubmit class="save" action="validateApprovedParticipants"
                            value="${message(code: 'management.participations.validateApprovedParticipants')}"/>
            <br>
            <label for="multiStatusCode"><g:message code="management.participations.multiUpdate"/></label>
            <g:select id="multiStatusCode" name="statusCode" from="${flexygames.Participation.constrainedProperties.statusCode.inList}"
                      valueMessagePrefix="participation.status" />
            <label for="multiUserLog"><g:message code="optionalText"/></label>
            <g:textField type="text" id="multiUserLog" name="userLog" />
            <g:actionSubmit class="save" action="updateParticipationStatus" value="${message(code: 'update')}"/>
        </div>
    </g:form>
