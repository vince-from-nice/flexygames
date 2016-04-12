<table>
    <tr>
        <th colspan="2"><g:message code="name" /></th>
        <th><g:message code="training" />?</th>
        <th><g:message code="competition" />?</th>
    </tr>
    <g:each in="${playerInstance.memberships}" var="m">
        <g:form>
            <g:hiddenField name="id" value="${m.id}" />
            <tr style="height: 40px; border: solid black 0px;">
                <td style="vertical-align: middle; text-align: right; margin: 0px; padding: 0px">
                    <g:set var="team" value="${m.team}" />
                    <g:link controller="teams" action="show" id="${m.team.id}">
                        <g:link controller="teams" action="show" id="${team.id}">
                            <img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
                        </g:link>
                    </g:link>
                </td>
                <td style="vertical-align: middle; text-align: left">
                    <g:link controller="teams" action="show" id="${m.team.id}">
                        ${team}
                    </g:link>
                </td>
                <td style="vertical-align: middle;">
                    ${m.regularForTraining ? message(code:'regular') : message(code:'tourist')}
                </td>
                <td style="vertical-align: middle;">
                    ${m.regularForCompetition ? message(code:'regular') : message(code:'tourist')}
                </td>
            </tr>
        </g:form>
    </g:each>
</table>