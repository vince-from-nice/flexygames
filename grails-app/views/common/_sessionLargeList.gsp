				<g:set var="username" value="${org.apache.shiro.SecurityUtils.subject.principal}" />
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<g:if test="${sessionInstance.group.isVisibleByUsername(username)}">
						<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: sessionInstance.id, absolute: true)}" />
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="height: 40px;">
							<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
								<g:link controller="sessions" action="show" id="${sessionInstance.id}">
									<nobr><g:formatDate date="${sessionInstance.date}" format="EEEEEEE dd MMMM (HH:mm)" /></nobr>
								</g:link>
							</td>
							<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
								${fieldValue(bean: sessionInstance, field: "group")}
							</td>
							<td style="vertical-align: middle; margin: 0px; padding: 0px; ">
								<g:set var="team" value="${sessionInstance.group.defaultTeams.first()}" />
								<g:link controller="teams" action="show" id="${team.id}">
									<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
								</g:link>
							</td>
							<g:set var="color" value="#f33" />
				            <g:if test="${sessionInstance.availableParticipants.size() >= sessionInstance.group.defaultMinPlayerNbr}">
				                <g:set var="color" value="#3f3" />
				            </g:if>
							<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
								<nobr>	
					        	<span style="color: ${color}; font-weight:bold;">${sessionInstance.availableParticipants.size()} / ${sessionInstance.participations.size()}</span> 
					        	<span style="font-size: small">(min: ${sessionInstance.group.defaultMinPlayerNbr})</span>
					        	</nobr>
					        </td>
					        <g:render template="/common/status"  model="['sessionInstance': sessionInstance, 'username': org.apache.shiro.SecurityUtils.subject.principal]" />
							<g:if test="${request.display == 'desktop'}">
								<td style="vertical-align: middle;">${fieldValue(bean: sessionInstance, field: "playground")}</td>
								<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">${sessionInstance.rounds.size()}</td>
								<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">${sessionInstance.allVotes.size()}</td>
								<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">${sessionInstance.comments.size()}</td>
								<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'" >
									<g:if test="${sessionInstance.comments}">
										<g:set var="lastComment" value="${sessionInstance.comments.first()}" />
										<g:link controller="player" action="show" id="${lastComment.user.id}">
											${lastComment.user}
										</g:link>
										<g:message code="session.show.comments.hasPosted" />
										<g:link uri="/sessions/show/${sessionInstance.id}#comment${lastComment.id}">
											<flexy:humanDate date="${lastComment.date.time}" />
										</g:link>
									</g:if>
									<g:else>
										<g:message code="noComment" />
									</g:else>
								</td>
							</g:if>
						</tr>
					</g:if>
				</g:each>