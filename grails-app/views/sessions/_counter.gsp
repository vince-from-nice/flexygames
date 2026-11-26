			        <g:set var="enoughPlayers" value="${sessionInstance.availableParticipants.size() >= sessionInstance.group.defaultMinPlayerNbr}" />
			        <tr class="counter-row">
			            <th colspan="4">
			            	<span class="count-pill ${enoughPlayers ? 'ok' : 'low'}">
			            		<g:message code="session.show.participants.total" /> : ${sessionInstance.availableParticipants.size()} / ${sessionInstance.participations.size()}
			            	</span>
			            	<g:set var="approvedNbr" value="${sessionInstance.approvedParticipants.size()}" />
			            	<g:if test="${approvedNbr > 1 && sessionInstance.date > new Date()}">
				            	<span class="muted">(<g:message code="session.show.participants.total.approved" args="[approvedNbr]" />)</span>
			            	</g:if>
			            </th>
			            <th colspan="2" class="counter-limits">
			                 <g:message code="session.show.participants.min" />: <strong>${sessionInstance.group.defaultMinPlayerNbr}</strong> ·
			                 <g:message code="session.show.participants.preferred" />: <strong>${sessionInstance.group.defaultPreferredPlayerNbr}</strong> ·
			                 <g:message code="session.show.participants.max" />: <strong>${sessionInstance.group.defaultMaxPlayerNbr}</strong>
			            </th>
			        </tr>
