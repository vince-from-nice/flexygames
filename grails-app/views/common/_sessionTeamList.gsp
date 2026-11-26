				<g:set var="past" value="${false}" />
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<g:if test="${sessionInstance.date < new Date()}">
						<g:if test="${!past}">
							<tr class="now-row">
								<td colspan="7">
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
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${sessionInstance.canceled ? 'is-canceled' : ''} ${past ? 'is-past' : ''}">
							<td class="clickable" onclick="document.location='${sessionLink}'">
								<g:link controller="sessions" action="show" id="${sessionInstance.id}" class="date-cell">
									<strong><g:formatDate date="${sessionInstance.date}" format="EEEE dd MMMM" /></strong>
									<span><g:formatDate date="${sessionInstance.date}" format="HH:mm" /></span>
								</g:link>
							</td>
							<g:if test="${competition}">
								<td class="clickable" onclick="document.location='${sessionLink}'">${sessionInstance.name}</td>
								<td class="clickable" onclick="document.location='${sessionLink}'">
									<g:each in="${sessionInstance.rounds}" var="round">
										<g:set var="scoreForTeamA" value="${round.getActionsByTeam(true).size()}" />
										<g:set var="scoreForTeamB" value="${round.getActionsByTeam(false).size()}" />
										<span class="${scoreForTeamA > scoreForTeamB ? 'score-plus' : (scoreForTeamA < scoreForTeamB ? 'score-minus' : '')}">${scoreForTeamA}-${scoreForTeamB}</span>
									</g:each>
								</td>
							</g:if>
							<td class="small clickable" onclick="document.location='${sessionLink}'">${sessionInstance.playground}</td>
							<g:render template="/common/status" model="['sessionInstance': sessionInstance, 'username': request.currentUser?.username]" />
							<td class="clickable" onclick="document.location='${sessionLink}'">
								<span class="count-pill ${available >= sessionInstance.group.defaultMinPlayerNbr ? 'ok' : 'low'}">${available} / ${sessionInstance.participations.size()}</span>
							</td>
							<td class="small clickable" onclick="document.location='${sessionLink}'">
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
						</tr>
					</g:if>
				</g:each>
