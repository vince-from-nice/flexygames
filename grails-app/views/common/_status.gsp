<!-- Load the participation only if required -->
<g:if test="${part == null}">
    <g:set var="part" value="${sessionInstance.getParticipationOf(session.currentUser?.username)}"/>
</g:if>
<g:if test="${part!=null}">
    <td style="text-align: center; vertical-align: middle; border: solid black 1px; background-color: ${flexygames.Participation.Status.color(part?.statusCode)}; ">
        <g:form name="participationStatusForm${part.id}" method="get" controller="sessions" action="update">
            <g:hiddenField name="id" value="${part.id}"/>
            <g:hiddenField name="userLog" value=""/>
            <g:set var="possibleStatus" value="${[part.statusCode]}"/>
            <!-- Check if session is managed by current user only if required -->
            <g:if test="${allStatusesArePossible || sessionIsManagedByCurrentUser}">
                <g:set var="possibleStatus" value="${flexygames.Participation.constrainedProperties.statusCode.inList}"/>
            </g:if>
            <g:else>
                <g:if test="${session.currentUser?.username == part.player.username}">
                    <g:if test="${part.statusCode == flexygames.Participation.Status.REQUESTED.code}">
                        <g:set var="possibleStatus"
                               value="${[flexygames.Participation.Status.REQUESTED.code, flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}"/>
                    </g:if>
                    <g:if test="${part.statusCode == flexygames.Participation.Status.AVAILABLE.code}">
                        <g:set var="possibleStatus"
                               value="${[flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}"/>
                    </g:if>
                    <g:if test="${part.statusCode == flexygames.Participation.Status.DECLINED.code}">
                        <g:set var="possibleStatus"
                               value="${[flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}"/>
                    </g:if>
                    <g:if test="${part.statusCode == flexygames.Participation.Status.APPROVED.code}">
                        <g:set var="possibleStatus"
                               value="${[flexygames.Participation.Status.APPROVED.code, flexygames.Participation.Status.DECLINED.code]}"/>
                    </g:if>
                    <g:if test="${part.statusCode == flexygames.Participation.Status.WAITING_LIST.code}">
                        <g:set var="possibleStatus"
                               value="${[flexygames.Participation.Status.WAITING_LIST.code, flexygames.Participation.Status.DECLINED.code]}"/>
                    </g:if>
                </g:if>
            </g:else>
            <g:if test="${possibleStatus.size > 1}">
                <script>var promptMsg = '${message(code:'session.show.participants.enterMessage')}'</script>
                <g:if test="${allStatusesArePossible || sessionIsManagedByCurrentUser}">
                    <select
                            onChange="document.getElementById('participationStatusForm${part.id}').userLog.value = prompt(promptMsg, '');
                            document.getElementById('participationStatusForm${part.id}').submit()"
                            name="statusCode" style="font-size : 10px;">
                        <g:each in="${possibleStatus}" var="status">
                            <g:if test="${status == flexygames.Participation.Status.REQUESTED.code}">
                                <option disabled>── <g:message code="availability"/> ──</option>
                            </g:if>
                            <g:if test="${status == flexygames.Participation.Status.APPROVED.code}">
                                <option disabled>── <g:message code="selection"/> ──</option>
                            </g:if>
                            <g:if test="${status == flexygames.Participation.Status.DONE_GOOD.code}">
                                <option disabled>── <g:message code="reporting"/> ──</option>
                            </g:if>
                            <g:set var="selected" value=""/>
                            <g:if test="${status == part.statusCode}"><g:set var="selected" value="selected"/></g:if>
                            <option ${selected} value="${status}"><g:message code="participation.status.${status}"/></option>
                        </g:each>
                    </select>
                </g:if>
                <g:else>
                    <g:select
                            onChange="document.getElementById('participationStatusForm${part.id}').userLog.value = prompt(promptMsg, '');
		                    	document.getElementById('participationStatusForm${part.id}').submit()"
                            name="statusCode" from="${possibleStatus}" value="${part.statusCode}"
                            valueMessagePrefix="participation.status"
                            style="font-size : 14px"/>
                </g:else>
            </g:if>
            <g:else>
                <b><g:message code="participation.status.${part.statusCode}"/></b>
            </g:else>
        </g:form>
    </td>
</g:if>
<g:else>
    <td style="text-align: center; vertical-align: middle; border: solid black 1px; background-color: #EEEEEE; ">
        <g:message code="notJoined"/>
    </td>
</g:else>