
				<g:set var="groups" value="${teamInstance.getSessionGroups(params.mode=='competition')}" />
				<g:if test="${groups.size() == 0}">
					<g:if test="${params.mode=='competition' }">
						<i><g:message code="team.show.noSessionGroupsForCompetition" /></i>
					</g:if>
					<g:else>
						<i><g:message code="team.show.noSessionGroupsForTraining" /></i>
					</g:else>
				</g:if>
				<g:else>
					<g:if test="${params.group != null}">
						<g:set var="group" value="${flexygames.SessionGroup.get(params.group)}" />
					</g:if>
					<g:else>
						<g:set var="group" value="${groups.last()}" />
					</g:else>
					<g:form name="sessionGroupForm" action="show" method="get">
						<g:hiddenField name="id" value="${teamInstance.id}"/>
						<g:hiddenField name="mode" value="${params.mode}"/>
						<g:message code="team.show.selectSessionGroup" /> : 
						<g:select name="group" from="${teamInstance.getSessionGroups(params.mode=='competition')}"  
							optionKey="id" value="${group.id}" 
							onChange="document.getElementById('sessionGroupForm').submit();" />
					</g:form>
					<g:if test="${group}">
						<table class="flexyTab">
							<tr>
								<th><g:message code="date" /></th>
								<g:if test="${group.competition}">
									<th><g:message code="name" /></th>
								</g:if>
								<g:if test="${group.competition}">
									<th style=""><g:message code="Score" /></th>
								</g:if>
								<th><g:message code="playground" /></th>
								<th style="text-align: center"><g:message code="myStatus" /></th>
								<th style="text-align: center;"><g:message code="players" /></th>
								<th style="font-size: 12px; vertical-align: middle;"><g:message code="lastComment" /></th>
							</tr>
							<g:if test="${group.sessions.size() > 0}">
								<g:if test="${group.isVisibleByUsername(org.apache.shiro.SecurityUtils.subject.principal)}">
									<g:render template="/common/sessionTeamList" model="['sessionInstanceList': group.sessions, 'competition': group.competition]" />
								</g:if>
								<g:else>
									<tr>
										<td colspan="4"><g:message code="team.show.notVisibleGroup" /></td>
									</tr>
								</g:else>
							</g:if>
							<g:else>
								<tr>
									<td colspan="4"><i><g:message code="team.show.noSessions" /></i></td>
								</tr>
							</g:else>
						</table>
						<g:if test="${teamIsManagedByCurrentUser}">
							<g:form controller="manager" method="post">
							    <g:hiddenField name="id" value="${group?.id}" />
							    <g:hiddenField name="create" value="1" />
							    <div class="buttons">
						            <g:actionSubmit class="create" action="createSession" value="${message(code:'management.session.add')}" />
							    </div>
							</g:form>
						</g:if>
					</g:if>
					<g:else>
						<i>Invalid session group !</i>
					</g:else>
				</g:else>