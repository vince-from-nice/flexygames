    <g:message code="playground"/>: <g:link controller="playgrounds" action="show" id="${blogEntry.session.playground.id}">${blogEntry.session.playground}</g:link>
    &nbsp;&nbsp;
    <g:message code="session.show.participants"/>:
    <g:set var="color" value="#f33" />
    <g:if test="${blogEntry.session.availableParticipants.size() >= blogEntry.session.group.defaultMinPlayerNbr}">
        <g:set var="color" value="#3f3" />
    </g:if>
    <nobr>
        <span style="color: ${color}; font-weight:bold;">${blogEntry.session.availableParticipants.size()} / ${blogEntry.session.participations.size()}</span>
        <span style="font-size: 10px">(min: ${blogEntry.session.group.defaultMinPlayerNbr})</span>
    </nobr>
    <br />
    <g:if test="${blogEntry.session.comments}">
        <g:set var="lastComment" value="${blogEntry.session.comments.first()}"/>
        <g:message code="lastComment"/>
        <g:link uri="/sessions/show/${blogEntry.session.id}#comment${lastComment.id}">
            <flexy:humanDate date="${lastComment.date.time}"/>
        </g:link>
        <g:message code="by"/>
        <g:link controller="player" action="show" id="${lastComment.user.id}">
            ${lastComment.user}
        </g:link>:
        <g:set var="text" value="${lastComment.text.replaceAll('<br />', '')}"/>
        <g:if test="${text.size() > 100}">
            <g:set var="text" value="${text.substring(0, 100)}..."/>
        </g:if>
        <span style="font-style: italic; font-size: small">${text}</span>
    </g:if>
    <g:else>
        <g:message code="noComment"/>
    </g:else>