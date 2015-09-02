<g:if test="${sessionInstance.date.time < System.currentTimeMillis() }">
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('votesSummaryZone'); toggleTableDisplay('votesDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.votes" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<a id="votingArea"></a>
		<div id="votesSummaryZone" style="display: block;">
			<g:if test="${sessionInstance.votes.size() > 0}" >
				<g:message code="session.show.votes.votesNbr"/> : <b>${sessionInstance.rounds.size()}</b>
			</g:if>
			<g:else>
				<g:message code="session.show.votes.noVote"/>
			</g:else>
		</div>
		<table id="votesDetailedZone" style="display: none;">
			<tr>
				<th colspan="2" style="text-align: center; width: 40%"><g:message code="session.show.votes.menOfTheMatch" /></th>
				<th colspan="2" style="text-align: center; width: 40%"><g:message code="session.show.votes.bouletOfTheMatch" /></th>
				<th colspan="1" style="text-align: center; width: 20%"><g:message code="session.show.votes.scores" /></th>
			</tr>
			<tr>
			   <g:if test="${sessionInstance.votes.size() > 0}">
					<td colspan="2" style="text-align: center">
						<br />
						<g:set var="firstPlayer" value="${participantsByScore.first()}" />
						<g:link controller="player" action="show" id="${firstPlayer.id}">
							${firstPlayer}<br />
							<g:render template="/common/avatar" model="[player: firstPlayer]" />
						</g:link>
						<br /> 
						<g:if test="${java.lang.Math.abs(firstPlayer.scoreInCurrentSession) > 1}">
							<g:message code="session.show.votes.attribuedPoints" args="${[firstPlayer.scoreInCurrentSession]}" />
						</g:if>
						<g:else>
							<g:message code="session.show.votes.attribuedPoint" args="${[firstPlayer.scoreInCurrentSession]}" />
						</g:else>
						<br />
					</td>
					<td colspan="2" style="text-align: center">
						<br />
						<g:set var="lastPlayer" value="${participantsByScore.last()}" />
						<g:link controller="player" action="show" id="${lastPlayer.id}">
							${lastPlayer}<br />
							<g:render template="/common/avatar" model="[player: lastPlayer]" />
						</g:link><br />
						<g:if test="${java.lang.Math.abs(firstPlayer.scoreInCurrentSession) > 1}">
							<g:message code="session.show.votes.attribuedPoints" args="${[lastPlayer.scoreInCurrentSession]}" />
						</g:if>
						<g:else>
							<g:message code="session.show.votes.attribuedPoint" args="${[lastPlayer.scoreInCurrentSession]}" />
						</g:else>
						<br />
			        </td>
		        </g:if>
		        <g:else>
		            <td colspan="4" style="text-align: center"><br><i><g:message code="session.show.votes.noVote" /></i><br></td>
		        </g:else>
				<td colspan="1" rowspan="5">
					<g:if test="${participantsByScore.size() >= 6}">
						<g:message code="session.show.votes.bestPlayers" />
						<table>
							<g:set var="bestScorers" value="${participantsByScore[0..2]}"/>
							<g:each in="${bestScorers}" var="player">
								<tr>
									<td>
										<g:link controller="player" action="show" id="${player.id}">
											<g:render template="/common/avatar" model="[player: player]" />
										</g:link>
									</td>
									<td style="vertical-align: middle;">
										<g:link controller="player" action="show" id="${player.id}">
											${player.username}
										</g:link>
									</td>
									<td>${player.scoreInCurrentSession}</td>
								</tr>
							</g:each>
						</table>
						<g:message code="session.show.votes.worstPlayers" />
						<table>
							<g:set var="limit1" value="${participantsByScore.size() - 3}" />
							<g:set var="limit2" value="${participantsByScore.size() - 1}" />
							<g:set var="worstScorers" value="${participantsByScore[limit1..limit2]}"/>
							<g:each in="${worstScorers}" var="player">
								<tr>
									<td>
										<g:link controller="player" action="show" id="${player.id}">
											<g:render template="/common/avatar" model="[player: player]" />
										</g:link>
									</td>
									<td style="vertical-align: middle;">
										<g:link controller="player" action="show" id="${player.id}">
											${player.username}
										</g:link>
									</td>
									<td>${player.scoreInCurrentSession}</td>
								</tr>
							</g:each>
						</table>
					</g:if>
					<g:else>
						<g:message code="session.show.votes.allPlayers" />
						<table>
							<g:each in="${participantsByScore}" var="player">
								<tr>
									<td>
										<g:link controller="player" action="show" id="${player.id}">
											<g:render template="/common/avatar" model="[player: player]" />
										</g:link>
									</td>
									<td style="vertical-align: middle;">
										<g:link controller="player" action="show" id="${player.id}">
											${player.username}
										</g:link>
									</td>
									<td>${player.scoreInCurrentSession}</td>
								</tr>
							</g:each>
						</table>
					</g:else>
				</td>
			</tr>
			<g:if test="${sessionInstance.effectiveParticipants.size() > 0}">
			    <shiro:notUser>
			        <tr>
			            <th colspan="4" style="text-align: center"><g:message code="session.show.votes.needLogin" /></th>
			        </tr>
			    </shiro:notUser>
			    <shiro:user>
			        <tr>
			            <th colspan="4" style="text-align: center">
			            	<g:message code="session.show.votes.dispatch" /> :
						</th>
			            <!--td colspan="4" style="text-align: center">
			            	<input type="button" class="edit" value="${message(code:'session.show.votes.dispatch')}"
			            		onclick="toggleRowDisplay('firstVoteChoices'); toggleRowDisplay('secondVoteChoices'); toggleRowDisplay('thirdVoteChoices')" />
						</td-->
					</tr>
					<tr id="firstVoteChoices" style="display: table-row; height: 20px">
						<g:form action="vote">
							<g:hiddenField name="id" value="${sessionInstance?.id}" />
							<g:hiddenField name="voteType" value="firstPositive" />
							<td>
							    <b><g:message code="session.show.votes.firstChoice" /></b> <small>(<g:message code="session.show.votes.giveXpoints" args="${[3]}" />)</small>
							</td>
							<td>
								<g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.firstPositive}" noSelection="['':'']" />
								<g:actionSubmit value="Vote" action="vote" />
			                </td>
						</g:form>
			            <g:form action="vote">
			                <g:hiddenField name="id" value="${sessionInstance?.id}" />
			                <g:hiddenField name="voteType" value="firstNegative" />
			                <td>
			                    <b><g:message code="session.show.votes.firstChoice" /></b> <small>(<g:message code="session.show.votes.removeXpoints" args="${[3]}" />)</small>
			                </td>
			                <td>
			                    <g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.firstNegative}" noSelection="['':'']" />
			                    <g:actionSubmit value="Vote" action="vote" />
			                </td>
			            </g:form>
					</tr>
					<tr id="secondVoteChoices" style="display: table-row; height: 20px">
			            <g:form action="vote">
			                <g:hiddenField name="id" value="${sessionInstance?.id}" />
			                <g:hiddenField name="voteType" value="secondPositive" />
			                <td>
			                    <b><g:message code="session.show.votes.secondChoice" /></b> <small>(<g:message code="session.show.votes.giveXpoints" args="${[2]}" />)</small>
			                </td>
			                <td>
			                    <g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.secondPositive}" noSelection="['':'']" />
			                    <g:actionSubmit value="Vote" action="vote" />
			                </td>
			            </g:form>
			            <g:form action="vote">
			                <g:hiddenField name="id" value="${sessionInstance?.id}" />
			                <g:hiddenField name="voteType" value="secondNegative" />
			                <td>
			                    <b><g:message code="session.show.votes.secondChoice" /></b> <small>(<g:message code="session.show.votes.removeXpoints" args="${[2]}" />)</small>
			                </td>
			                <td>
			                    <g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.secondNegative}" noSelection="['':'']" />
			                    <g:actionSubmit value="Vote" action="vote" />
			                </td>
			            </g:form>
					</tr>
					<tr id="thirdVoteChoices" style="display: table-row; height: 20px">
			            <g:form action="vote">
			                <g:hiddenField name="id" value="${sessionInstance?.id}" />
			                <g:hiddenField name="voteType" value="thirdPositive" />
			                <td>
			                    <b><g:message code="session.show.votes.thirdChoice" /></b> <small>(<g:message code="session.show.votes.give1point" />)</small>
			                </td>
			                <td>
			                    <g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.thirdPositive}" noSelection="['':'']" />
			                    <g:actionSubmit value="Vote" action="vote" />
			                </td>
			            </g:form>
			            <g:form action="vote">
			                <g:hiddenField name="id" value="${sessionInstance?.id}" />
			                <g:hiddenField name="voteType" value="thirdNegative" />
			                <td>
			                    <b><g:message code="session.show.votes.thirdChoice" /></b> <small>(<g:message code="session.show.votes.remove1point" />)</small>
			                </td>
			                <td>
			                    <g:select name="player" from="${sessionInstance.effectiveParticipants}" value="${currentVotes.thirdNegative}" noSelection="['':'']" />
			                    <g:actionSubmit value="Vote" action="vote" />
			                </td>
			            </g:form>
					</tr>
			    </shiro:user>
		    </g:if>
		 </table>
	</div>
</div>
</g:if>
<g:set scope="request" var="timeAfterVoting" value="${java.lang.System.currentTimeMillis()}" />
