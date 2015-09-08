
<g:set var="part" value="${sessionInstance.getParticipationOf(username)}" />
<g:if test="${part}">
	<td style="text-align: center; vertical-align: middle; border: solid black 1px; background-color: ${flexygames.Participation.Status.color(part.statusCode)}; ">
		<g:form name="participationStatusForm${part.id}" method="get" controller="sessions" action="update">
			<g:hiddenField name="id" value="${part.id}" />
			<g:hiddenField name="userLog" value="" />
			<g:set var="possibleStatus" value="${[part.statusCode]}" />
			<g:if test="${part.session.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
				<g:set var="possibleStatus" value="${part.constraints.statusCode.inList}" />
			</g:if>
			<g:else>
				<g:if test="${org.apache.shiro.SecurityUtils.subject.principal == part.player.username}">
					<g:if test="${part.statusCode == flexygames.Participation.Status.REQUESTED.code}">
						<g:set var="possibleStatus" value="${[flexygames.Participation.Status.REQUESTED.code, flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}" />
					</g:if>
					<g:if test="${part.statusCode == flexygames.Participation.Status.AVAILABLE.code}">
						<g:set var="possibleStatus" value="${[flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}" />
					</g:if>
					<g:if test="${part.statusCode == flexygames.Participation.Status.DECLINED.code}">
						<g:set var="possibleStatus" value="${[flexygames.Participation.Status.AVAILABLE.code, flexygames.Participation.Status.DECLINED.code]}" />
					</g:if>
					<g:if test="${part.statusCode == flexygames.Participation.Status.APPROVED.code}">
						<g:set var="possibleStatus" value="${[flexygames.Participation.Status.APPROVED.code, flexygames.Participation.Status.DECLINED.code]}" />
					</g:if>
					<g:if test="${part.statusCode == flexygames.Participation.Status.WAITING_LIST.code}">
						<g:set var="possibleStatus" value="${[flexygames.Participation.Status.WAITING_LIST.code, flexygames.Participation.Status.DECLINED.code]}" />
					</g:if>
				</g:if>
			</g:else>
			<g:if test="${possibleStatus.size > 1}">
				<script>var promptMsg = '${message(code:'session.show.participants.enterMessage')}'</script>
				<g:select
					onChange="document.getElementById('participationStatusForm${part.id}').userLog.value = prompt(promptMsg, ''); 
		                    	document.getElementById('participationStatusForm${part.id}').submit()"
					name="statusCode" from="${possibleStatus}" value="${part.statusCode}"
					valueMessagePrefix="participation.status"
					style="font-size : 10px"  />
			</g:if>
			<g:else>
				<b><g:message code="participation.status.${part.statusCode}" /></b>
			</g:else>
		</g:form>
	</td>
</g:if>
<g:else>
	<td style="text-align: center; vertical-align: middle; border: solid black 1px; background-color: #EEEEEE; ">
		<g:message code="notJoined" />
	</td>
</g:else>