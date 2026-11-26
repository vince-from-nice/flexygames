<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('votesSummaryZone'); toggleDisplay('votesDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.votes" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<g:set var="defaultDisplayForSummaryZone" value="block" />
	<g:set var="defaultDisplayForDetailedZone" value="none" />
	<g:if test="${sessionInstance.date < new Date() || sessionInstance.votes.size() > 0}">
		<g:set var="defaultDisplayForSummaryZone" value="none" />
		<g:set var="defaultDisplayForDetailedZone" value="block" />
	</g:if>
	<div class="sessionZoneContent">
		<a id="votingArea"></a>
		<g:if test="${flash.votingMessage}">
			<div class="message">${flash.votingMessage}</div>
		</g:if>
		<g:if test="${flash.votingError}">
			<div class="errors">${flash.votingError}</div>
		</g:if>
		<div id="votesSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.votes.size() > 0}">
				<g:message code="session.show.votes.votesNbr"/> : <strong>${sessionInstance.rounds.size()}</strong>
			</g:if>
			<g:else>
				<span class="muted"><g:message code="session.show.votes.noVote"/></span>
			</g:else>
		</div>
		<div id="votesDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<p class="muted"><g:message code="session.show.votes.intro" /></p>
			<div class="votes-grid">
				<g:if test="${sessionInstance.votes.size() > 0}">
					<g:each in="${[['session.show.votes.menOfTheMatch', participantsByScore.first(), 'best'], ['session.show.votes.bouletOfTheMatch', participantsByScore.last(), 'worst']]}" var="podium">
						<section class="podium-card ${podium[2]}">
							<h3><g:message code="${podium[0]}" /></h3>
							<g:render template="/common/avatar" model="[player: podium[1], width: '72px']" />
							<g:link controller="player" action="show" id="${podium[1].id}" class="player-name">${podium[1]}</g:link>
							<span class="muted small"><g:message code="${Math.abs(podium[1].scoreInCurrentSession) > 1 ? 'session.show.votes.attribuedPoints' : 'session.show.votes.attribuedPoint'}" args="${[podium[1].scoreInCurrentSession]}" /></span>
						</section>
					</g:each>
				</g:if>
				<g:else>
					<p class="podium-empty muted"><g:message code="session.show.votes.noVote" /></p>
				</g:else>

				<section class="vote-scores">
					<h3><g:message code="session.show.votes.scores" /></h3>
					<g:if test="${participantsByScore.size() >= 6}">
						<g:set var="scoreLists" value="${[['session.show.votes.bestPlayers', participantsByScore[0..2]], ['session.show.votes.worstPlayers', participantsByScore[(participantsByScore.size() - 3)..(participantsByScore.size() - 1)]]]}" />
					</g:if>
					<g:else>
						<g:set var="scoreLists" value="${[['session.show.votes.allPlayers', participantsByScore]]}" />
					</g:else>
					<g:each in="${scoreLists}" var="scoreList">
						<p class="small muted"><g:message code="${scoreList[0]}" /></p>
						<ol class="score-list">
							<g:each in="${scoreList[1]}" var="player">
								<li>
									<span class="avatar-cell"><g:render template="/common/avatar" model="[player: player]" /></span>
									<g:link controller="player" action="show" id="${player.id}" class="player-name">${player.username}</g:link>
									<span class="${player.scoreInCurrentSession > 0 ? 'score-plus' : (player.scoreInCurrentSession < 0 ? 'score-minus' : '')}">${player.scoreInCurrentSession}</span>
								</li>
							</g:each>
						</ol>
					</g:each>
				</section>
			</div>

			<g:if test="${sessionInstance.effectiveParticipants.size() > 0}">
				<shiro:notUser>
					<p class="muted"><g:message code="session.show.votes.needLogin" /></p>
				</shiro:notUser>
				<shiro:user>
					<g:form action="vote" class="vote-form">
						<g:hiddenField name="id" value="${sessionInstance?.id}" />
						<h3><g:message code="session.show.votes.dispatch" /></h3>
						<div class="vote-columns">
							<fieldset class="vote-column best">
								<legend><g:message code="session.show.votes.menOfTheMatch" /></legend>
								<div class="field">
									<label for="firstChoiceBestPlayer"><g:message code="session.show.votes.firstChoice" /> <span class="muted small">(<g:message code="session.show.votes.giveXpoints" args="${[3]}" />)</span></label>
									<g:select name="firstChoiceBestPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.firstPositive}" noSelection="['':'']" />
								</div>
								<div class="field">
									<label for="secondChoiceBestPlayer"><g:message code="session.show.votes.secondChoice" /> <span class="muted small">(<g:message code="session.show.votes.giveXpoints" args="${[2]}" />)</span></label>
									<g:select name="secondChoiceBestPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.secondPositive}" noSelection="['':'']" />
								</div>
								<div class="field">
									<label for="thirdChoiceBestPlayer"><g:message code="session.show.votes.thirdChoice" /> <span class="muted small">(<g:message code="session.show.votes.give1point" />)</span></label>
									<g:select name="thirdChoiceBestPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.thirdPositive}" noSelection="['':'']" />
								</div>
							</fieldset>
							<fieldset class="vote-column worst">
								<legend><g:message code="session.show.votes.bouletOfTheMatch" /></legend>
								<div class="field">
									<label for="firstChoiceWorstPlayer"><g:message code="session.show.votes.firstChoice" /> <span class="muted small">(<g:message code="session.show.votes.removeXpoints" args="${[3]}" />)</span></label>
									<g:select name="firstChoiceWorstPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.firstNegative}" noSelection="['':'']" />
								</div>
								<div class="field">
									<label for="secondChoiceWorstPlayer"><g:message code="session.show.votes.secondChoice" /> <span class="muted small">(<g:message code="session.show.votes.removeXpoints" args="${[2]}" />)</span></label>
									<g:select name="secondChoiceWorstPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.secondNegative}" noSelection="['':'']" />
								</div>
								<div class="field">
									<label for="thirdChoiceWorstPlayer"><g:message code="session.show.votes.thirdChoice" /> <span class="muted small">(<g:message code="session.show.votes.remove1point" />)</span></label>
									<g:select name="thirdChoiceWorstPlayer" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.thirdNegative}" noSelection="['':'']" />
								</div>
							</fieldset>
						</div>
						<g:actionSubmit value="${message(code:'session.show.votes.applyMyVotes')}" action="vote" />
					</g:form>
				</shiro:user>
			</g:if>
		</div>
	</div>
</div>
<g:set scope="request" var="timeAfterVoting" value="${java.lang.System.currentTimeMillis()}" />
