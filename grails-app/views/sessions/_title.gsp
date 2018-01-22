<table style="width: 100%">
    <tr>
        <td style="text-align: left; vertical-align: middle">
            <g:if test="${sessionInstance.previousSessionInGroup}">
                <g:link action="show" id="${sessionInstance.previousSessionInGroup.id}">&lt;&lt; <g:message code="session.show.previous" /></g:link>
            </g:if>
            <g:else>
                &lt;&lt; <g:message code="session.show.previous" />
            </g:else>
        </td>
        <td style="text-align: center; vertical-align: middle">
            <g:if test="${sessionInstance.name}">
                <h1 style="margin: 0px">${fieldValue(bean: sessionInstance, field: "name")}</h1>
            </g:if>
            <g:else>
                <h1 style="margin: 0px">
                    <g:message code="session.show.title" />
                    <g:formatDate date='${sessionInstance?.date}' format="EEEEEEE dd MMMM" />
                </h1>
            </g:else>
        </td>
        <td style="text-align: right; vertical-align: middle">
            <g:if test="${sessionInstance.nextSessionInGroup}">
                <g:link action="show" id="${sessionInstance.nextSessionInGroup.id}"><g:message code="session.show.next" /> &gt;&gt;</g:link>
            </g:if>
            <g:else>
                <g:message code="session.show.next" /> &gt;&gt;
            </g:else>
        </td>
    </tr>
</table>
