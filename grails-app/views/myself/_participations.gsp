<table>
    <tr>
        <th style="width: 40px; ">&nbsp;</th>
        <th><g:message code="name" /></th>
        <th><g:message code="training" />?</th>
        <th><g:message code="competition" />?</th>
        <th></th>
        <th></th>
    </tr>
    <g:if test="${playerInstance.memberships.size() > 0}">
        <g:each in="${playerInstance.memberships}" var="m">
            <g:form>
                <g:hiddenField name="id" value="${m.id}" />
                <tr>
                    <td style="vertical-align: middle; text-align: right; margin: 0px; padding: 0px;">
                        <img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:m.team.logoName)}" alt="Team logo" />
                    </td>
                    <td><g:link controller="teams" action="show" id="${m.team.id}">${m.team}</g:link></td>
                    <td>
                        <g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForTraining ? message(code:'regular') : message(code:'tourist')}" />
                    </td>
                    <td>
                        <g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForCompetition ? message(code:'regular') : message(code:'tourist')}" />
                    </td>
                    <td>
                        <span class="button"><g:actionSubmit class="edit" action="updateMembership" value="${message(code:'update')}" /> </span>
                    </td>
                    <td>
                        <span class="button"><g:actionSubmit class="remove" action="leaveTeam" value="${message(code:'leave')}" /> </span>
                    </td>
                </tr>
            </g:form>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="6"><i><g:message code="myAccount.noTeams" /></i></td>
        </tr>
    </g:else>
    <tr>
        <th colspan="6" style="text-align: center"><g:message code="myAccount.joinNewTeam" /></th>
    </tr>
    <g:form>
        <tr>
            <td colspan="2"><g:select name="id" from="${flexygames.Team.list(sort:'name', order:'asc')}" optionKey="id" /></td>
            <td><g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" /> </td>
            <td><g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" /></td>
            <td colspan="2"><span class="button"><g:actionSubmit class="create" action="joinTeam" value="${message(code:'join')}" /> </span></td>
        </tr>
    </g:form>
</table>
<h3><g:message code="myAccount.membershipExplanation.title" /></h3>
<p><g:message code="myAccount.membershipExplanation.text" /></p>