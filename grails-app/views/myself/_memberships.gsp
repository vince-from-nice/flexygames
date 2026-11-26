<div class="table-wrap">
<table class="flexyTab">
    <tr>
        <th></th>
        <th><g:message code="name" /></th>
        <th><g:message code="training" />?</th>
        <th><g:message code="competition" />?</th>
        <th></th>
        <th></th>
    </tr>
    <g:if test="${playerInstance.memberships.size() > 0}">
        <g:each in="${playerInstance.getSortedMemberships()}" var="m">
            <g:form>
                <g:hiddenField name="id" value="${m.id}" />
                <tr>
                    <td class="team-cell"><flexy:teamLogo team="${m.team}" /></td>
                    <td><g:link controller="teams" action="show" id="${m.team.id}">${m.team}</g:link></td>
                    <td>
                        <g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForTraining ? message(code:'regular') : message(code:'tourist')}" aria-label="${message(code: 'training')}" />
                    </td>
                    <td>
                        <g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForCompetition ? message(code:'regular') : message(code:'tourist')}" aria-label="${message(code: 'competition')}" />
                    </td>
                    <td><g:actionSubmit class="edit" action="updateMembership" value="${message(code:'update')}" /></td>
                    <td><g:actionSubmit class="remove" action="leaveTeam" value="${message(code:'leave')}" /></td>
                </tr>
            </g:form>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="6" class="muted"><g:message code="myAccount.noTeams" /></td>
        </tr>
    </g:else>
</table>
</div>

<h3><g:message code="myAccount.joinNewTeam" /></h3>
<g:form class="inline-row">
    <g:select name="id" from="${flexygames.Team.list(sort:'name', order:'asc')}" optionKey="id" aria-label="${message(code: 'myAccount.joinNewTeam')}" />
    <label><g:message code="training" />? <g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" /></label>
    <label><g:message code="competition" />? <g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" /></label>
    <g:actionSubmit class="create" action="joinTeam" value="${message(code:'join')}" />
</g:form>

<h3><g:message code="myAccount.membershipExplanation.title" /></h3>
<p class="muted small"><g:message code="myAccount.membershipExplanation.text" /></p>
