
				<div class="table-wrap">
				<table class="flexyTab">
					<tr>
						<th></th>
						<th colspan="1"><g:message code="name" /></th>
						<th class="number"><g:message code="statistics" /></th>
						<th class="number"><g:message code="training" /></th>
						<th class="number"><g:message code="competition" /></th>
						<th class="number"><g:message code="lastLogin" /></th>
					</tr>
					<g:each in="${teamInstance.memberships}" var="ms" status="i">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td class="avatar-cell"> 
								<g:link controller="player" action="show" id="${ms.user.id}">
									<g:render template="/common/avatar" model="[player: ms.user]" />
								</g:link>
							</td>
							<td> 
								<g:link controller="player" action="show" id="${ms.user.id}">
									${fieldValue(bean: ms.user, field: "username")}
								</g:link><br />
								<nobr>
								<g:if test="${ms.feesUpToDate}">
									<span class="small score-plus"><g:message code="team.show.membership.feesUpToDate" /></span>
								</g:if>
								<g:else>
									<span class="small score-minus"><g:message code="team.show.membership.feesNotUpToDate" /></span>
								</g:else>
								</nobr>
								<br/>
								<nobr>
									<span class="small muted"><g:message code="player.show.scores.votes"/>: <b>${ms.user.voteCounter}</b></span>
								</nobr>
							</td>
							<td class="number small">
								<nobr>
									<b>${ms.user.participationCounter}</b>
									<g:if test="${ms.user.participationCounter > 1}"><g:message code="participations" /></g:if>
									<g:else><g:message code="participation" /></g:else> 
								</nobr>
								<br />
								<nobr>
									<span style="color: ${flexygames.Participation.Status.UNDONE.color}">
										<g:if test="${ms.user.absenceCounter > 1}"><b>${ms.user.absenceCounter}</b> <g:message code="absences" /><br /></g:if>
										<g:if test="${ms.user.absenceCounter == 1}"><b>1</b> <g:message code="absence" /><br /></g:if>
									</span>
								</nobr>
								<nobr>
									<span style="color: ${flexygames.Participation.Status.DONE_BAD.color}">
										<g:if test="${ms.user.gateCrashCounter > 1}"><b>${ms.user.gateCrashCounter}</b> <g:message code="gatecrashes" /><br /></g:if>
										<g:if test="${ms.user.gateCrashCounter == 1}"><b>1</b> <g:message code="gatecrash" /><br /></g:if>
									</span>
								</nobr>
								<nobr>
									<span style="color: ${flexygames.Participation.Status.DONE_LATE.color}">
										<g:if test="${ms.user.delayCounter > 1}"><b>${ms.user.delayCounter}</b> <g:message code="delays" /><br /></g:if>
										<g:if test="${ms.user.delayCounter == 1}"><b>1</b> <g:message code="delay" /><br /></g:if>
									</span>
								</nobr>
								<nobr>
									<span style="color: ${flexygames.Participation.Status.WAITING_LIST.color}">
										<g:if test="${ms.user.waitingListCounter > 1}"><b>${ms.user.waitingListCounter}</b> <g:message code="waitinglists" /><br /></g:if>
										<g:if test="${ms.user.waitingListCounter == 1}"><b>1</b> <g:message code="waitinglists" /><br /></g:if>
									</span>
								</nobr>
							</td>
							<td class="number small">
								<g:if test="${ms.regularForTraining}">
									<b><g:message code="regular" /></b>
								</g:if>
								<g:else>
									<g:message code="tourist" />
								</g:else>
							</td>
							<td class="number small">
								<g:if test="${ms.regularForCompetition}">
									<b><g:message code="regular" /></b>
								</g:if>
								<g:else>
									<g:message code="tourist" />
								</g:else>
							</td>
							<td class="number small">
								<g:formatDate date="${ms.user.lastLogin}" format="yyyy-MM-dd" timeStyle="LONG" />
							</td>
						</tr>
					</g:each>
				</table>
				</div>

				<g:if test="${teamIsManagedByCurrentUser}">
				
					<div class="management">
					
						<h3><g:message code="management.membership.title" /></h3>
						
						<g:form controller="manager">
							<g:message code="management.membership.updateMember.text" /> :
							<div class="field-row">
								<div class="field">
									<label for="id"><g:message code="username" /></label>
									<g:select name="id" from="${teamInstance.memberships}" optionKey="id" optionValue="user" key="id"/>
								</div>
								<div class="field">
									<label for="regularForTraining"><g:message code="training" /></label>
									<g:select name="regularForTraining" from="['Regular', 'Tourist']" />
								</div>
								<div class="field">
									<label for="regularForCompetition"><g:message code="competition" /></label>
									<g:select name="regularForCompetition" from="['Regular', 'Tourist']" />
								</div>
								<div class="field">
									<label for="feesUpToDate"><g:message code="subscription" /></label>
									<g:select name="feesUpToDate" from="['UpToDate', 'NotUpToDate']" />
								</div>
							</div>
							<div class="form-actions">
								<g:actionSubmit action="updateMembership" value="${message(code:'update')}" />
								<g:actionSubmit action="removeMembership" class="delete" value="${message(code:'delete')}"
									onclick="return confirm('${message(code:'management.membership.remove.warning')}')" />
							</div>
						</g:form>
						
						<g:form controller="manager">
							<g:hiddenField name="id" value="${teamInstance.id}"/>
							<g:message code="management.membership.updateAllMembers.text" /> :
							<select name="with">
 									<option value="cotizOk"><g:message code="management.membership.updateAllMembers.cotizOk" /></option>
 									<option value="cotizKo"><g:message code="management.membership.updateAllMembers.cotizKo" /></option>
 									<option value="regularForCompetition"><g:message code="management.membership.updateAllMembers.regularForCompetition" /></option>
 									<option value="regularForTraining"><g:message code="management.membership.updateAllMembers.regularForTraining" /></option>
 									<option value="touristForCompetition"><g:message code="management.membership.updateAllMembers.touristForCompetition" /></option>
 									<option value="touristForTraining"><g:message code="management.membership.updateAllMembers.touristForTraining" /></option>
							</select>
							<g:actionSubmit class="edit" action="updateAllMemberships" value="${message(code:'management.membership.updateAllMembers')}" />
						</g:form>

						<br>
						<div class="buttons">
							<g:link controller="manager" action="showAttendanceSheet" id="${teamInstance.id}"><g:message code="management.attendenceSheets.showAttendanceSheets" /></g:link>
						</div>
						
					</div>
					
				</g:if>