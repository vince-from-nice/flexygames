				<g:set var="future" value="${false}" />
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<g:if test="${sessionInstance.date > new Date()}">
						<g:if test="${!future}">
							<tr style="height: 5px;">
								<td colspan="10" style="background-color: #FFB2B2; font-size: 12px; line-height: 10px; text-align: center; color: red">
									<g:message code="home.session.currentHour" /> :
									<g:formatDate date="${new Date()}" format="EEEEEEE dd MMMM (HH:mm)" />
								</td>
							</tr>
						</g:if>
						<g:set var="future" value="${true}" />
					</g:if>
					<g:if test="${sessionInstance.group.isVisibleByUsername(session.currentUser?.username)}">
						<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: sessionInstance.id, absolute: true)}" />
						<g:if test="${lastDate != sessionInstance.date.toString().substring(0, sessionInstance.date.toString().length() - 10)}">
							<tr>
								<td colspan="6" style="text-align: center; font-size: larger">
									<b><nobr><g:formatDate date="${sessionInstance.date}" format="EEEEEEE dd MMMM" /></nobr></b>
								</td>
							</tr>
						</g:if>
						<g:set var="lastDate" value="${sessionInstance.date.toString().substring(0, sessionInstance.date.toString().length() - 10)}" />
						<g:if test="${sessionInstance.canceled}">
							<g:set var="isCanceled" value="text-decoration: line-through;"/>
						</g:if>
						<g:else>
							<g:set var="isCanceled" value="" />
						</g:else>
						<tr style="height: 40px; vertical-align: middle; ${isCanceled}" class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td style="text-align: center;  cursor: pointer; vertical-align: middle; margin: 0px; padding: 0px;" onclick="document.location='${sessionLink}'">
								<g:set var="team" value="${sessionInstance.group.defaultTeams.first()}" />
								<g:link controller="teams" action="show" id="${team.id}">
									<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
								</g:link>
							</td>
							<td style="vertical-align: middle; cursor: pointer;" onclick="document.location='${sessionLink}'">
								<g:link controller="sessions" action="list" params="${['filteredSessionGroup':sessionInstance.group.id]}">
								</g:link>
								${fieldValue(bean: sessionInstance, field: "group")}
							</td>
							<td style="vertical-align: middle; cursor: pointer;" onclick="document.location='${sessionLink}'">
								<nobr><g:formatDate date="${sessionInstance.date}" format="HH:mm" /></nobr>
							</td>
							<td style="vertical-align: middle; cursor: pointer;" onclick="document.location='${sessionLink}'">
								<g:set var="color" value="#f33" />
					            <g:if test="${sessionInstance.availableParticipants.size() >= sessionInstance.group.defaultMinPlayerNbr}">
					                <g:set var="color" value="#3f3" />
					            </g:if>
								<nobr>	
					        	<span style="color: ${color}; font-weight:bold;">${sessionInstance.availableParticipants.size()} / ${sessionInstance.participations.size()}</span> 
					        	<span style="font-size: 10px">(min: ${sessionInstance.group.defaultMinPlayerNbr})</span>
					        	</nobr>
					        </td>
					        <g:render template="/common/status"  model="['sessionInstance': sessionInstance, 'username': session.currentUser?.username]" />
							<td style="vertical-align: middle; ">
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
						</tr>
					</g:if>
				</g:each>