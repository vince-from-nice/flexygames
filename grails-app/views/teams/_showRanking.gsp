
	<table style="border: 0px; ">
		<tr>
			<td style="vertical-align: top">
				<g:form name="statsForm" action="show">
					<g:hiddenField name="id" value="${teamInstance.id}"/>
					<g:hiddenField name="mode" value="${params.mode}"/>
					<div style="border: 2px solid darkcyan; background-color: #ddeedd; color: darkgreen; padding: 10px; width: auto">
					<g:message code="stats.selectCriteria" /> :
					<br />
					<g:select name="criteria" value="${currentCriteria}" valueMessagePrefix="stats.criteria" from="[
							'statuses.doneGood',
							'statuses.doneBad',
							'statuses.undone',
							'statuses.removed',
							'actionScore',
							'actionByRound',
							'votingScore',
							'successRatio']" />
					<g:if test="${currentCriteria == 'actionByRound' || currentCriteria == 'successRatio'}">
						<br />
						<br />
						<div style="border: 2px solid red; background-color: #FFF3F3; color: orange; padding: 10px; width: auto">
							<g:message code="stats.minPartsForAverage" />
						</div>
					</g:if>
					<br/>
					<br />
					<g:message code="stats.selectSessionGroup" /> :
					<br/>
					<g:select name="sessionGroupId" value="${currentSessionGroupId}" from="${teamInstance.sessionGroups}" optionKey="id"
							  noSelection="['0': message(code:'session.list.filter.allSessionGroups')]" />
					<br/>
					<br/>
					<g:message code="stats.clickAndWait" /> :
					<g:submitButton name="Click & Wait" />
					</div>
					<br/>
					<br/>
					<div style="border: 2px solid orange; background-color: #FFF3F3; color: darkgreen; padding: 10px; width: auto">
						<g:message code="stats.clickAndWaitExplanation" />
					</div>
				</g:form>
			</td>
			<td>
				<table style="width: auto; text-align: center">
					<g:set var="rank" value="1" />
					<g:set var="lastValue" value="0" />
					<tr>
						<th style="text-align: left"><g:message code="rank" /></th>
						<th colspan="2"><g:message code="player" /></th>
						<th><g:message code="stats.criteria.${currentCriteria}" /></th>
					</tr>
					<g:each var="item" in="${members}" status="i">
						<g:if test="${item.value != lastValue}"><g:set var="borderStyle" value="border-top: solid black 1px; " /></g:if>
						<g:else><g:set var="borderStyle" value="" /></g:else>
						<g:set var="userLink" value="${createLink(controller: 'player', action: 'show', id: item.key.id, absolute: true)}" />
						<tr style="${borderStyle}; cursor: pointer" onclick="document.location='${userLink}'">
							<td>
								<g:if test="${item.value != lastValue}"><g:set var="rank" value="${i+1}" />${rank}</g:if>
							</td>
							<td style="vertical-align: middle; height: 50px">
								<g:render template="/common/avatar" model="[player: item.key]" />
							</td>
							<td style="vertical-align: middle;">
								${fieldValue(bean: playerInstance, field: "username")}&nbsp;${fieldValue(bean: item.key, field: "username")}
							</td>
							<td><g:formatNumber number="${item.value}" maxFractionDigits="2" minFractionDigits="2" /></td>
						</tr>
						<g:set var="lastValue" value="${item.value}" />
					</g:each>
				</table>
			</td>
		</tr>
	</table>


