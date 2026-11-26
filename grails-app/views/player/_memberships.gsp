<g:if test="${playerInstance.memberships}">
    <ul class="team-list">
        <g:each in="${playerInstance.getSortedMemberships()}" var="m">
            <li>
                <g:link controller="teams" action="show" id="${m.team.id}" title="${m.team}"><flexy:teamLogo team="${m.team}" /></g:link>
                <span class="team-list-name">
                    <g:link controller="teams" action="show" id="${m.team.id}">${m.team}</g:link>
                    <span class="small muted">
                        <g:message code="training" />: ${m.regularForTraining ? message(code: 'regular') : message(code: 'tourist')}
                        · <g:message code="competition" />: ${m.regularForCompetition ? message(code: 'regular') : message(code: 'tourist')}
                    </span>
                </span>
            </li>
        </g:each>
    </ul>
</g:if>
