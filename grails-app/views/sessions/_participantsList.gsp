            <table class="flexyTab">
                <thead>
                <tr>
                    <g:if test="${sessionIsManagedByCurrentUser}"><th></th></g:if>
                    <th style="vertical-align: top; text-align: center;" colspan="2"><g:message code="player"/></th>
                    <th style="vertical-align: top;">&nbsp;</th>
                    <g:if test="${!mobile}"><th style="vertical-align: top;"><g:message code="teams"/></th></g:if>
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
                            <g:if test="${p.player != request.currentUser}">
                                <g:javascript>pendingParticipationIds.push(${p.id});</g:javascript>
                                <g:set var="display" value="${hidePendingPlayersByDefault?'none':'table-row'}"/>
                            </g:if>
                        </g:if>
                        <tr id="participation-${p.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}" style="display: ${display}; border: solid grey 1px">
                            <g:if test="${sessionIsManagedByCurrentUser}">
                                <td style="vertical-align: middle; text-align: center; padding: 2px;">
                                    <input type="checkbox" name="selectParticipation${p.id}" form="managementForm"/>
                                </td>
                            </g:if>
                            <td style="text-align: center; height: 50px; padding-left: 0px">
                                <g:render template="/common/avatar" model="[player: p.player]"/>
                            </td>
                            <td style="text-align: left; padding-left: 0px; border: solid grey 0px">
                                <g:link controller="player" action="show" id="${p.player.id}">
                                    ${p.player}
                                </g:link><br/>
                                <nobr>
                                    <g:if test="${p.player.membershipInCurrentSession?.feesUpToDate}">
                                        <span style="font-size: 10px; color: green"><g:message code="team.show.membership.feesUpToDate"/></span>
                                    </g:if>
                                    <g:else>
                                        <span style="font-size: 10px; color: red"><g:message code="team.show.membership.feesNotUpToDate"/></span>
                                    </g:else>
                                </nobr>
                            </td>
                            <td style="font-size: 10px; border: solid grey 0px">
                                <g:set var="amnestyTime" value="${java.lang.System.currentTimeMillis() - Integer.valueOf(grailsApplication.config.flexygames.amnestyDaysNbr) * 24 * 60 * 60 * 1000}" />
                                <nobr>
                                    <span style="font-size: 12px;">
                                        <g:set var="count" value="${p.player.participationCounter}"/>
                                        <b>${count}</b>
                                        <g:if test="${count > 1}"><g:message code="participations"/></g:if>
                                        <g:else><g:message code="participation"/></g:else>
                                    </span>
                                </nobr>
                                <br/>
                                <nobr>
                                    <span style="color: ${flexygames.Participation.Status.UNDONE.color}">
                                        <g:set var="count" value="${p.player.absenceCounter}"/>
                                        <g:if test="${count > 1}"><b>${count}</b> <g:message code="absences"/></g:if>
                                        <g:if test="${count == 1}"><b>1</b> <g:message code="absence"/></g:if>
                                        <g:if test="${count > 0}">
                                            <g:if test="${amnestyTime < p.player.absenceLastDate?.time}">
                                                <span class="blink_text">(<g:message code="session.show.participants.recently"/>)</span>
                                            </g:if>
                                            <br/>
                                        </g:if>
                                    </span>
                                </nobr>
                                <nobr>
                                    <span style="color: #cecc4e">
                                        <g:set var="count" value="${p.player.delayCounter}"/>
                                        <g:if test="${count > 1}"><b>${count}</b> <g:message code="delays"/></g:if>
                                        <g:if test="${count == 1}"><b>1</b> <g:message code="delay"/></g:if>
                                        <g:if test="${count > 0}">
                                            <g:if test="${amnestyTime < p.player.delayLastDate?.time}">
                                                <span class="blink_text">(<g:message code="session.show.participants.recently"/>)</span>
                                            </g:if>
                                            <br/>
                                        </g:if>
                                    </span>
                                </nobr>
                                <nobr>
                                    <span style="color: ${flexygames.Participation.Status.DONE_BAD.color}">
                                        <g:set var="count" value="${p.player.gateCrashCounter}"/>
                                        <g:if test="${count > 1}"><b>${count}</b> <g:message code="gatecrashes"/></g:if>
                                        <g:if test="${count == 1}"><b>1</b> <g:message code="gatecrash"/></g:if>
                                        <g:if test="${count > 0}">
                                            <g:if test="${amnestyTime < p.player.gateCrashLastDate?.time}">
                                                <span class="blink_text">(<g:message code="session.show.participants.recently"/>)</span>
                                            </g:if>
                                            <br/>
                                        </g:if>
                                    </span>
                                </nobr>
                                <nobr>
                                    <span style="color: ${flexygames.Participation.Status.WAITING_LIST.color}">
                                        <g:set var="count" value="${p.player.waitingListCounter}"/>
                                        <g:if test="${count > 1}"><b>${count}</b> <g:message code="waitinglists"/></g:if>
                                        <g:if test="${count == 1}"><b>1</b> <g:message code="waitinglist"/></g:if>
                                        <g:if test="${count > 0}">
                                            <g:if test="${amnestyTime < p.player.waitingListLastDate?.time}">
                                                <span class="blink_text">(<g:message code="session.show.participants.recently"/>)</span>
                                            </g:if>
                                            <br/>
                                        </g:if>
                                    </span>
                                </nobr>
                            </td>
                            <g:if test="${!mobile}">
                            <td style="font-size: 10px; line-height: 10px; border: solid grey 1px">
                                <g:each in="${p.player.teamsInCurrentSession}" var="t">
                                    <g:link controller="teams" action="show" id="${t.id}">${t}</g:link><br/>
                                </g:each>
                            </td>
                            </g:if>
                            <g:render template="/common/status" model="['part': p, 'allStatusesArePossible':sessionIsManagedByCurrentUser]"/>
                            <td style="background-color: ${flexygames.Participation.Status.color(p.statusCode)}; font-size: 12px; border: solid black 1px">
                                <g:if test="${p.lastUpdate}">
                                    <g:message code="session.show.participants.lastUpdate" args="[]"/>
                                    <b><flexy:humanDate date="${p.lastUpdate.time}"/></b>
                                    <g:if test="${p.lastUpdater}"><g:message code="by"/> ${p.lastUpdater}</g:if>
                                    <g:if test="${p.userLog?.length() > 0}">: <span style="font-size: 12px"><i>${p.userLog}</i></span></g:if>
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
