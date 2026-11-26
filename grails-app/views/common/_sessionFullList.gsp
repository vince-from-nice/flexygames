				<g:set var="past" value="${false}" />
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<g:if test="${sessionInstance.date < new Date()}">
						<g:if test="${!past}">
							<tr class="now-row">
								<td colspan="11">
									<g:message code="home.session.currentHour" /> :
									<g:formatDate date="${new Date()}" format="EEEE dd MMMM (HH:mm)" />
								</td>
							</tr>
						</g:if>
						<g:set var="past" value="${true}" />
					</g:if>
					<g:if test="${sessionInstance.group.isVisibleByUsername(request.currentUser?.username)}">
						<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: sessionInstance.id, absolute: true)}" />
						<g:set var="available" value="${sessionInstance.availableParticipants.size()}" />
						<g:set var="minimum" value="${sessionInstance.group.defaultMinPlayerNbr}" />
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${sessionInstance.canceled ? 'is-canceled' : ''} ${past ? 'is-past' : ''}">
							<td class="clickable" onclick="document.location='${sessionLink}'">
								<g:link controller="sessions" action="show" id="${sessionInstance.id}" class="date-cell">
									<strong><g:formatDate date="${sessionInstance.date}" format="EEEE dd MMMM" /></strong>
									<span><g:formatDate date="${sessionInstance.date}" format="HH:mm" /></span>
								</g:link>
							</td>
							<td class="team-cell">
								<g:set var="team" value="${sessionInstance.group.defaultTeams.first()}" />
								<g:link controller="teams" action="show" id="${team.id}" title="${team}">
									<flexy:teamLogo team="${team}" />
								</g:link>
							</td>
							<td class="clickable" onclick="document.location='${sessionLink}'">
								<span class="count-pill ${available >= minimum ? 'ok' : 'low'}">${available} / ${sessionInstance.participations.size()}</span>
								<span class="count-min">min ${minimum}</span>
							</td>
							<g:render template="/common/status" model="['sessionInstance': sessionInstance, 'username': request.currentUser?.username]" />
							<g:if test="${request.display == 'desktop'}">
								<td class="col-optional small">${fieldValue(bean: sessionInstance, field: "playground")}</td>
								<td class="col-optional number clickable" onclick="document.location='${sessionLink}'">${sessionInstance.rounds.size()}</td>
								<td class="col-optional number clickable" onclick="document.location='${sessionLink}'">${sessionInstance.allVotes.size()}</td>
								<td class="col-optional number clickable" onclick="document.location='${sessionLink}'">${sessionInstance.comments.size()}</td>
								<td class="col-optional small clickable" onclick="document.location='${sessionLink}'">
									<g:if test="${sessionInstance.comments}">
										<g:set var="lastComment" value="${sessionInstance.comments.first()}" />
										<g:link controller="player" action="show" id="${lastComment.user.id}">${lastComment.user}</g:link>
										<g:message code="session.show.comments.hasPosted" />
										<g:link uri="/sessions/show/${sessionInstance.id}#comment${lastComment.id}"><flexy:humanDate date="${lastComment.date.time}" /></g:link>
									</g:if>
									<g:else>
										<span class="muted"><g:message code="noComment" /></span>
									</g:else>
								</td>
							</g:if>
						</tr>
					</g:if>
				</g:each>
