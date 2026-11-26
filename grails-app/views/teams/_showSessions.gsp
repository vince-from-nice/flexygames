
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
					<g:form name="sessionGroupForm" action="show" method="get" class="inline-row">
						<g:hiddenField name="id" value="${teamInstance.id}"/>
						<g:hiddenField name="mode" value="${params.mode}"/>
						<label for="group"><g:message code="team.show.selectSessionGroup" /></label>
						<g:select name="group" from="${teamInstance.getSessionGroups(params.mode=='competition')}"  
							optionKey="id" value="${group.id}" 
							onChange="document.getElementById('sessionGroupForm').submit();" />
					</g:form>
					<g:if test="${group}">
						<div class="table-wrap">
						<table class="flexyTab">
							<tr>
								<th><g:message code="date" /></th>
								<g:if test="${group.competition}">
									<th><g:message code="name" /></th>
								</g:if>
								<g:if test="${group.competition}">
									<th><g:message code="Score" /></th>
								</g:if>
								<th><g:message code="playground" /></th>
								<th class="status-head"><g:message code="myStatus" /></th>
								<th><g:message code="players" /></th>
								<th><g:message code="lastComment" /></th>
							</tr>
							<g:if test="${group.sessions.size() > 0}">
								<g:if test="${group.isVisibleByUsername(request.currentUser?.username)}">
									<g:render template="/common/sessionTeamList" model="['sessionInstanceList': group.sessions, 'competition': group.competition]" />
								</g:if>
								<g:else>
									<tr>
										<td colspan="7" class="muted"><g:message code="team.show.notVisibleGroup" /></td>
									</tr>
								</g:else>
							</g:if>
							<g:else>
								<tr>
									<td colspan="7" class="muted"><g:message code="team.show.noSessions" /></td>
								</tr>
							</g:else>
						</table>
						</div>
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