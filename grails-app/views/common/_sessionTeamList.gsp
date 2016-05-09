				<g:set var="username" value="${org.apache.shiro.SecurityUtils.subject.principal}" />
				<g:set var="now" value="${System.currentTimeMillis()}" />
				<g:set var="past" value="${false}" />
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<g:if test="${sessionInstance.date.getTime() < now}">
						<g:if test="${!past}">
							<tr style="height: 5px;">
								<td colspan="7" style="background-color: #FFB2B2; line-height: 10px; text-align: center; color: red">
									<g:message code="home.session.currentHour" /> :
									<g:formatDate date="${new Date(now)}" format="EEEEEEE dd MMMM (HH:mm)" />	 
								</td>
							</tr>
						</g:if>
						<g:set var="past" value="${true}" />
					</g:if>
					<g:if test="${sessionInstance.group.isVisibleByUsername(username)}">
						<g:set var="sessionLink" value="${createLink(controller: 'sessions', action: 'show', id: sessionInstance.id, absolute: true)}" />
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
						
							<!-- Date -->
							<td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
								<nobr><g:formatDate date="${sessionInstance.date}" format="EEEEEEE dd MMMM (HH:mm)" /></nobr>
							</td>
							
							<!-- Name -->
							<g:if test="${competition}">
						        <td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
										<nobr>${sessionInstance.name}</nobr>
						        </td>
					        </g:if>
					        
					        <!-- Score -->
					        <g:if test="${competition}">
						        <td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
						        	<g:each in="${sessionInstance.rounds}" var="round" >
						        		<g:set var="scoreForTeamA" value="${round.getActionsByTeam(true).size()}" />
						        		<g:set var="scoreForTeamB" value="${round.getActionsByTeam(false).size()}" />
										<g:set var="color" value="#444" />
				            			<g:if test="${scoreForTeamA > scoreForTeamB}">
				                			<g:set var="color" value="#2f2" />
				            			</g:if>
				            			<g:if test="${scoreForTeamA < scoreForTeamB}">
				                			<g:set var="color" value="#f22" />
				            			</g:if>
										<span style="color: ${color}; font-weight:bold;">
											<nobr>${scoreForTeamA}-${scoreForTeamB}</nobr>  
										</span>
									</g:each>
						        </td>
					        </g:if>

					        <!-- Playground -->
					        <td style="vertical-align: middle; cursor: pointer" onclick="document.location='${sessionLink}'">
					        	${sessionInstance.playground}
					        </td>
					        
					        <!-- Status -->
					        <g:render template="/common/status"  model="['sessionInstance': sessionInstance, 'username': org.apache.shiro.SecurityUtils.subject.principal]" />

					        <!-- Players Numbers -->
							<g:set var="color" value="#f33" />
				            <g:if test="${sessionInstance.availableParticipants.size() >= sessionInstance.group.defaultMinPlayerNbr}">
				                <g:set var="color" value="#3f3" />
				            </g:if>
							<td style="vertical-align: middle; text-align: center; cursor: pointer" onclick="document.location='${sessionLink}'">
					        	<span style="color: ${color}; font-weight:bold;">${sessionInstance.availableParticipants.size()} / ${sessionInstance.participations.size()}</span> 
					        </td>
					        					        
					        <!-- Comments -->
							<td style="vertical-align: middle; font-size: 12px" onclick="document.location='${sessionLink}'" style="cursor: pointer;">
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