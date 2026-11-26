<div class="session-title">
    <g:if test="${sessionInstance.previousSessionInGroup}">
        <g:link action="show" id="${sessionInstance.previousSessionInGroup.id}" class="btn btn-ghost">&larr; <g:message code="session.show.previous" /></g:link>
    </g:if>
    <g:else>
        <span class="btn btn-ghost is-disabled">&larr; <g:message code="session.show.previous" /></span>
    </g:else>

    <h1>
        <g:if test="${sessionInstance.name}">
            ${fieldValue(bean: sessionInstance, field: "name")}
        </g:if>
        <g:else>
            <g:message code="session.show.title" />
            <g:formatDate date='${sessionInstance?.date}' format="EEEE dd MMMM" />
        </g:else>
    </h1>

    <g:if test="${sessionInstance.nextSessionInGroup}">
        <g:link action="show" id="${sessionInstance.nextSessionInGroup.id}" class="btn btn-ghost"><g:message code="session.show.next" /> &rarr;</g:link>
    </g:if>
    <g:else>
        <span class="btn btn-ghost is-disabled"><g:message code="session.show.next" /> &rarr;</span>
    </g:else>
</div>
