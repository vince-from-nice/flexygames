<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <g:render template="/common/layout" />
</head>
<body>
<h1><g:message code="management.attendenceSheets.title" args="${team}" /></h1>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:form controller="manager" name="sessionGroupForm" action="showAttendanceSheet" method="GET">
    <g:hiddenField name="id" value="${team.id}" />
    <g:message code="management.attendenceSheets.selectSessionGroup" />
    <g:select name='groupId' from="${team.sessionGroups}"
              optionKey="id" value="${flexygames.SessionGroup.get(params.groupId).id}"
              noSelection="${['':'']}"
    />
    <br />
    <g:message code="management.attendenceSheets.valuetoDispatch" />
    <g:field type="number" name="valueToDispatch" min="0" size="2" value="${params.valueToDispatch}"/>
    <g:submitButton name="Go" />
</g:form>
<br />
<table style="width: 100%; border: solid black 1px;">
    <tr>
        <th>&nbsp;</th>
        <g:each in="${sessions}" var="session">
            <th><g:formatDate date="${session.date}" format="dd/MM" /></th>
        </g:each>
        <th><g:message code="total" /></th>
        <th><g:message code="management.attendenceSheets.signature" /></th>
    </tr>
    <g:each in="${data}" var="row">
        <tr style="width: 100%; border: solid black 1px;">
            <td>
              ${row.key}
            </td>
            <g:each in="${row.value}" var="v" status="i">
                <g:set var="color" value="grey" />
                <g:if test="${i < row.value.size() - 1}">
                    <g:if test="${v != 'X'}">
                        <g:set var="color" value="green" />
                    </g:if>
                    <td style="text-align: center; vertical-align: middle; color: ${color}">
                        <nobr>${v}</nobr>
                    </td>
                </g:if>
                <g:else>
                    <td style="text-align: center; vertical-align: middle;">
                        <b><nobr>${v}</nobr></b>
                    </td>
                </g:else>
            </g:each>
            <td style="text-align: center; vertical-align: middle; width: 100em; border-left: solid black 1px; ">
                &nbsp;
            </td>
        </tr>
    </g:each>
</table>
</body>
</html>
