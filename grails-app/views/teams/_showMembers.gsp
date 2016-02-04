
				<table class="flexyTab">
					<tr>
						<th></th>
						<th colspan="1"><g:message code="name" /></th>
						<th style="vertical-align: middle; text-align: center;"><g:message code="statistics" /></th>
						<th style="vertical-align: middle; text-align: center;"><g:message code="training" /></th>
						<th style="vertical-align: middle; text-align: center;"><g:message code="competition" /></th>
						<th style="vertical-align: middle" property="lastLogin" ><g:message code="lastLogin" /></th>
					</tr>
					<g:each in="${teamInstance.memberships}" var="ms" status="i">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td style="vertical-align: middle; height: 50px"> 
								<g:link controller="player" action="show" id="${ms.user.id}">
									<g:render template="/common/avatar" model="[player: ms.user]" />
								</g:link>
							</td>
							<td style="text-align: left; vertical-align: middle; height: 50px"> 
								<g:link controller="player" action="show" id="${ms.user.id}">
									${fieldValue(bean: ms.user, field: "username")}
								</g:link><br />
								<nobr>
								<g:if test="${ms.feesUpToDate}">
									<span style="font-size: 10px; color: green"><g:message code="team.show.membership.feesUpToDate" /></span>
								</g:if>
								<g:else>
									<span style="font-size: 10px; color: red"><g:message code="team.show.membership.feesNotUpToDate" /></span>
								</g:else>
								</nobr>
							</td>
							<td style="text-align: center; vertical-align: middle; font-size: 12px; ">
								<nobr>
									<b>${ms.user.countParticipations()}</b>
									<g:if test="${ms.user.countParticipations() > 1}"><g:message code="participations" /></g:if>
									<g:else><g:message code="participation" /></g:else> 
								</nobr>
								<br />
									<nobr>
										<span style="color: red">
											<g:if test="${ms.user.countAbsences() > 1}"><b>${ms.user.countAbsences()}</b> <g:message code="absences" /><br /></g:if>
											<g:if test="${ms.user.countAbsences() == 1}"><b>1</b> <g:message code="absence" /><br /></g:if>
										</span>
									</nobr>
									<nobr>
										<span style="color: #cc0">
											<g:if test="${ms.user.countGateCrashes() > 1}"><b>${ms.user.countGateCrashes()}</b> <g:message code="gatecrashes" /><br /></g:if>
											<g:if test="${ms.user.countGateCrashes() == 1}"><b>1</b> <g:message code="gatecrash" /><br /></g:if>
										</span>
									</nobr>
								<nobr>
									<g:link controller="player" action="stats" id="${ms.user.id}">
										<g:message code="detailledStats" />
									</g:link>
								</nobr>
							</td>
							<td style="text-align: center; vertical-align: middle; font-size: 12px;">
								<g:if test="${ms.regularForTraining}">
									<b><g:message code="regular" /></b>
								</g:if>
								<g:else>
									<g:message code="tourist" />
								</g:else>
							</td>
							<td style="text-align: center; vertical-align: middle; font-size: 12px;">
								<g:if test="${ms.regularForCompetition}">
									<b><g:message code="regular" /></b>
								</g:if>
								<g:else>
									<g:message code="tourist" />
								</g:else>
							</td>
							<td style="text-align: center; vertical-align: middle; font-size: 12px; ">
								<g:formatDate date="${ms.user.lastLogin}" format="yyyy-MM-dd" timeStyle="LONG" />
							</td>
						</tr>
					</g:each>
				</table>

				<g:if test="${teamIsManagedByCurrentUser}">
				
					<div style="border: 2px dotted gray;padding: 0em 1em; background-color: #FCFBC4; margin-bottom: 1em; color: #800000; font-size: 12px" >
					
						<h3><g:message code="management.membership.title" /></h3>
						
						<g:form controller="manager">
							<g:message code="management.membership.updateMember.text" /> :
							<table>
								<tr>
									<th style="font-size: 10px; vertical-align: middle; text-align: center;"><g:message code="username" /></th>
									<th style="font-size: 10px; vertical-align: middle; text-align: center;"><g:message code="training" /></th>
									<th style="font-size: 10px; vertical-align: middle; text-align: center;"><g:message code="competition" /></th>
									<th style="font-size: 10px; vertical-align: middle; text-align: center;"><g:message code="subscription" /></th>
								</tr>
								<tr>
									<td colspan="1" style="text-align: center; vertical-align: middle;">
										<g:select name="id" from="${teamInstance.memberships}" optionKey="id"  optionValue="user" key="id"/>
									</td>
									<td style="text-align: center; vertical-align: middle;">
										<g:select name="regularForTraining" from="['Regular', 'Tourist']" />
									</td>
									<td style="text-align: center; vertical-align: middle;">
										<g:select name="regularForCompetition" from="['Regular', 'Tourist']" />
									</td>
									<td style="text-align: center; vertical-align: middle;">
										<g:select name="feesUpToDate" from="['UpToDate', 'NotUpToDate']" />
									</td>
								</tr> 
								<tr>
									<td colspan="4" style="text-align: center">
										<br />
										<g:actionSubmit action="updateMembership" value="${message(code:'update')}" />
										<g:actionSubmit action="removeMembership" value="${message(code:'delete')}"
										 	onclick="return confirm('${message(code:'management.membership.remove.warning')}')" />
									</td>
								</tr>
							</table>
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
						
					</div>
					
				</g:if>