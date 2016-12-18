            <table class="flexyTab">
                <thead>
                <tr>
                    <th style="vertical-align: top; text-align: center;" colspan="2"><g:message code="player"/></th>
                    <th style="vertical-align: top;">&nbsp;</th>
                    <th style="vertical-align: top;"><g:message code="teams"/></th>
                    <th style="vertical-align: top; text-align: center;"><g:message code="status"/></th>
                    <th style="vertical-align: top; min-width: 200px;"><g:message code="log"/></th>
                </tr>
                </thead>
                <tbody>
                <g:if test="${sessionInstance.participations.size() > 0}">
                    <g:javascript>var pendingParticipationIds = [];</g:javascript>
                    <g:each in="${sessionInstance.participations}" status="i" var="p">
                        <g:set var="display" value="table-row"/>
                        <g:if test="${p.statusCode == flexygames.Participation.Status.REQUESTED.code}">
                            <g:if test="${p.player != session.currentUser}">
                                <g:javascript>pendingParticipationIds.push(${p.id});</g:javascript>
                                <g:set var="display" value="${hidePendingPlayersByDefault?'none':'table-row'}"/>
                            </g:if>
                        </g:if>
                        <tr id="participation-${p.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}"
                            style="display: ${display}; border: solid grey 1px">
                            <td style="text-align: right; height: 50px; padding-left: 0px">
                                <g:render template="/common/avatar" model="[player: p.player]"/>
                            </td>
                            <td style="padding-left: 0px; border: solid grey 0px">
                                <g:link controller="player" action="show" id="${p.player.id}">
                                    ${p.player}
                                </g:link><br/>
                                <nobr>
                                    <g:if test="${p.player.membershipInCurrentSession?.feesUpToDate}">
                                        <span style="font-size: 10px; color: green"><g:message
                                                code="team.show.membership.feesUpToDate"/></span>
                                    </g:if>
                                    <g:else>
                                        <span style="font-size: 10px; color: red"><g:message
                                                code="team.show.membership.feesNotUpToDate"/></span>
                                    </g:else>
                                </nobr>
                            </td>
                            <td style="font-size: 10px; border: solid grey 0px">
                                <nobr>
                                    <b>${p.player.countParticipations()}</b>
                                    <g:if test="${p.player.countParticipations() > 1}"><g:message
                                            code="participations"/></g:if>
                                    <g:else><g:message code="participation"/></g:else>
                                </nobr>
                                <br/>
                                <nobr>
                                    <span style="color: red">
                                        <g:if test="${p.player.countAbsences() > 1}"><b>${p.player.countAbsences()}</b> <g:message
                                                code="absences"/><br/></g:if>
                                        <g:if test="${p.player.countAbsences() == 1}"><b>1</b> <g:message
                                                code="absence"/><br/></g:if>
                                    </span>
                                </nobr>
                                <nobr>
                                    <span style="color: #cc0">
                                        <g:if test="${p.player.countGateCrashes() > 1}"><b>${p.player.countGateCrashes()}</b> <g:message
                                                code="gatecrashes"/><br/></g:if>
                                        <g:if test="${p.player.countGateCrashes() == 1}"><b>1</b> <g:message
                                                code="gatecrash"/><br/></g:if>
                                    </span>
                                </nobr>
                                <nobr>
                                    <g:link controller="player" action="stats" id="${p.player.id}">
                                        <g:message code="detailledStats"/>
                                    </g:link>
                                </nobr>
                            </td>
                            <td style="font-size: 10px; line-height: 10px; border: solid grey 1px">
                                <g:each in="${p.player.teamsInCurrentSession}" var="t">
                                    <g:link controller="teams" action="show" id="${t.id}">${t}</g:link><br/>
                                </g:each>
                            </td>
                            <g:render template="/common/status" model="['part': p, 'allStatusesArePossible':sessionIsManagedByCurrentUser]"/>
                            <td style="background-color: ${flexygames.Participation.Status.color(p.statusCode)}; font-size: 12px; border: solid black 1px">
                                <g:if test="${p.lastUpdate}">
                                    <g:message code="session.show.participants.lastUpdate" args="[]"/>
                                    <b><flexy:humanDate date="${p.lastUpdate.time}"/></b>
                                    <g:if test="${p.lastUpdater}">
                                        <g:message code="by"/> ${p.lastUpdater}
                                    </g:if>
                                    <g:if test="${p.userLog?.length() > 0}">: <span
                                            style="font-size: 12px"><i>${p.userLog}</i></span></g:if>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="6" style="text-align: center; ">
                            <br/><br/><br/><br/><br/><br/>
                            <g:message code="session.show.participants.empty"/>
                            <br/><br/><br/><br/><br/><br/>
                        </td>
                    </tr>
                </g:else>
                </tbody>
                <thead>
                    <g:render template="counter" model="[]"/>
                </thead>
                <g:if test="${!currentUserParticipation}">
                    <tbody>
                        <tr>
                            <td colspan="6" style="text-align: center">
                                <g:form controller="sessions" action="join">
                                    <g:hiddenField name="id" value="${sessionInstance?.id}"/>
                                    <g:actionSubmit class="create"
                                                    onclick="return confirm('${message(code: 'session.show.participants.join.alert')}');"
                                                    action="join"
                                                    value="${message(code: 'session.show.participants.join')}"/>
                                </g:form>
                            </td>
                        </tr>
                    </tbody>
                </g:if>
            </table>
