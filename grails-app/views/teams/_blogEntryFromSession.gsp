<g:set var="style" value="trainingBlogEntry" />
<g:set var="color" value="#6ea7ff" />
<g:set var="code" value="nextTraining" />
<g:if test="${competition}">
    <g:set var="style" value="competitionBlogEntry" />
    <g:set var="color" value="#ef4a3e" />
    <g:set var="code" value="nextCompetition" />
</g:if>
<g:if test="${blogEntry}">
    <g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: blogEntry.id, absolute: true)}" />
    <div class="${style}" style="cursor: pointer" onclick="document.location='${sessionLink}'">
        <h2 style="margin-top: 0.1em;">
            <g:message code="team.show.blog.${code}"/>:
            <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" />
        </h2>
        <hr style="border-color: ${color}; margin-bottom: 0.6em;">
        <g:if test="${blogEntry.name}">
            <b>${blogEntry.name}</b><br>
        </g:if>
        <g:message code="session.show.participants"/>:
        <g:set var="c" value="#f33" />
        <g:if test="${blogEntry.availableParticipants.size() >= blogEntry.group.defaultMinPlayerNbr}">
            <g:set var="c" value="#3f3" />
        </g:if>
        <nobr>
            <span style="color: ${c}; font-weight:bold;">${blogEntry.availableParticipants.size()} / ${blogEntry.participations.size()}</span>
        </nobr>
        <br />
        <g:message code="playground"/>: <g:link controller="playgrounds" action="show" id="${blogEntry.playground.id}">${blogEntry.playground}</g:link>
        <br />
        <g:if test="${blogEntry.comments}">
            <g:set var="lastComment" value="${blogEntry.comments.first()}"/>
            <g:message code="lastComment"/>
            <g:link uri="/sessions/show/${blogEntry.id}#comment${lastComment.id}">
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
        <br />
        <g:message code="group" default="Group" />:
        <g:set var="mode" value="training" />
        <g:if test="${blogEntry.group.competition}">
            <g:set var="mode" value="competition" />
        </g:if>
        <g:link controller="teams" action="show" id="${blogEntry.group.defaultTeams?.first().id}" params="${['mode':mode, 'group':blogEntry.group.id]}">
            ${blogEntry?.group?.encodeAsHTML()}
        </g:link>
    </div>
</g:if>
<g:else>
    <div class="${style}">
        <h2 style="margin-top: 0.1em"><g:message code="team.show.blog.${code}"/></h2>
        <hr style="border-color:  ${color}; margin-bottom: 0.6em;">
        <g:message code="team.show.blog.${code}.nothing" />
    </div>
</g:else>

