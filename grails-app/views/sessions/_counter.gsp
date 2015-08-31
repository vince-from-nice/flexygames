
			        <tr style="width: 100%;">
			            <g:set var="color" value="red" />
			            <g:if test="${sessionInstance.availableParticipants.size() >= sessionInstance.group.defaultMinPlayerNbr}">
			                <g:set var="color" value="#3c3" />
			            </g:if>
			            <th colspan="4" style="text-align: left; vertical-align: top; ">
			            	<span style="font-size: 18px ; color: ${color};">
			            		<g:message code="session.show.participants.total" /> : <b>${sessionInstance.availableParticipants.size()} / ${sessionInstance.participations.size()}</b>
			            	</span>
			            	<g:set var="approvedNbr" value="${sessionInstance.approvedParticipants.size()}" />
			            	<g:if test="${approvedNbr > 1 && sessionInstance.date > new Date()}">
				            	<span style="font-size: 14px ; color: ${color};">
				            		(<g:message code="session.show.participants.total.approved" args="[approvedNbr]" />) 
				            	</span>
			            	</g:if>
			            </th>
			            <th colspan="2" style="text-align: right; vertical-align: top; ">
			                 [
			                 <g:message code="session.show.participants.min" />: ${sessionInstance.group.defaultMinPlayerNbr},
			                 <g:message code="session.show.participants.preferred" />: ${sessionInstance.group.defaultPreferredPlayerNbr},
			                 <g:message code="session.show.participants.max" />: ${sessionInstance.group.defaultMaxPlayerNbr}
			                 ]
			            </th>
			        </tr>