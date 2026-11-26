	<div class="ranking-layout">
		<g:form name="statsForm" action="show" class="stacked-form ranking-criteria">
			<g:hiddenField name="id" value="${teamInstance.id}"/>
			<g:hiddenField name="mode" value="${params.mode}"/>
			<label for="criteria"><g:message code="stats.selectCriteria" /></label>
			<g:select name="criteria" value="${currentCriteria}" valueMessagePrefix="stats.criteria" from="[
					'statuses.present',
					'statuses.doneGood',
					'statuses.doneLate',
					'statuses.doneBad',
					'statuses.undone',
					'statuses.removed',
					'actionScore',
					'actionByRound',
					'votingScore',
					'successRatio',
					'tasks.BALLS',
					'tasks.JERSEY',
					'tasks.CAMERAMAN',
					'tasks.BEERS',
					'tasks.COACHING',
					'tasks.REFEREE']" />
			<g:if test="${currentCriteria == 'actionByRound' || currentCriteria == 'successRatio'}">
				<p class="message small"><g:message code="stats.minPartsForAverage" /></p>
			</g:if>
			<label for="sessionGroupId"><g:message code="stats.selectSessionGroup" /></label>
			<g:select name="sessionGroupId" value="${currentSessionGroupId}" from="${teamInstance.sessionGroups}" optionKey="id"
					  noSelection="['0': message(code:'session.list.filter.allSessionGroups')]" />
			<g:submitButton name="Click & Wait" value="${message(code: 'stats.clickAndWait')}" />
			<p class="muted small"><g:message code="stats.clickAndWaitExplanation" /></p>
		</g:form>

		<div class="table-wrap">
			<table class="flexyTab">
				<g:set var="rank" value="1" />
				<g:set var="lastValue" value="0" />
				<tr>
					<th class="number"><g:message code="rank" /></th>
					<th colspan="2"><g:message code="player" /></th>
					<th class="number"><g:message code="stats.criteria.${currentCriteria}" /></th>
				</tr>
				<g:each var="item" in="${membersRanking}" status="i">
					<g:set var="userLink" value="${createLink(controller: 'player', action: 'show', id: item.key.id, absolute: true)}" />
					<tr class="clickable ${item.value != lastValue ? 'rank-break' : ''}" onclick="document.location='${userLink}'">
						<td class="number">
							<g:if test="${item.value != lastValue}"><g:set var="rank" value="${i+1}" /><strong>${rank}</strong></g:if>
						</td>
						<td class="avatar-cell"><g:render template="/common/avatar" model="[player: item.key]" /></td>
						<td><g:link controller="player" action="show" id="${item.key.id}" class="player-name">${fieldValue(bean: item.key, field: "username")}</g:link></td>
						<td class="number"><g:formatNumber number="${item.value}" maxFractionDigits="2" minFractionDigits="2" /></td>
					</tr>
					<g:set var="lastValue" value="${item.value}" />
				</g:each>
			</table>
		</div>
	</div>
