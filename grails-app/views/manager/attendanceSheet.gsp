<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="management.attendenceSheets.title" args="${team}" /></h1>
		<button type="button" class="btn btn-ghost no-print" onclick="window.print()"><g:message code="print" /></button>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<section class="card no-print">
		<g:form controller="manager" name="sessionGroupForm" action="showAttendanceSheet" method="GET" class="inline-row">
			<g:hiddenField name="id" value="${team.id}" />
			<label for="groupId"><g:message code="management.attendenceSheets.selectSessionGroup" /></label>
			<g:select name="groupId" from="${team.sessionGroups}" optionKey="id" value="${flexygames.SessionGroup.get(params.groupId)?.id}" noSelection="${['':'']}" />
			<label for="valueToDispatch"><g:message code="management.attendenceSheets.valuetoDispatch" /></label>
			<g:field type="number" name="valueToDispatch" min="0" value="${params.valueToDispatch}" class="number-input"/>
			<g:submitButton name="Go" />
		</g:form>
	</section>
	<section class="card">
		<div class="table-wrap">
			<table class="flexyTab attendance-sheet">
				<tr>
					<th>&nbsp;</th>
					<g:each in="${sessions}" var="session">
						<th class="number"><g:formatDate date="${session.date}" format="dd/MM" /></th>
					</g:each>
					<th class="number"><g:message code="total" /></th>
					<th class="signature"><g:message code="management.attendenceSheets.signature" /></th>
				</tr>
				<g:each in="${data}" var="row">
					<tr>
						<td><strong>${row.key}</strong></td>
						<g:each in="${row.value}" var="v" status="i">
							<g:if test="${i < row.value.size() - 1}">
								<td class="number ${v != 'X' ? 'present' : 'absent'}">${v}</td>
							</g:if>
							<g:else>
								<td class="number"><strong>${v}</strong></td>
							</g:else>
						</g:each>
						<td class="signature">&nbsp;</td>
					</tr>
				</g:each>
			</table>
		</div>
	</section>
</body>
</html>
