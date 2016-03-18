
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<h1>${fieldValue(bean: playerInstance, field: "username")}</h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<table style="width: 100%; border: 0px">
		<tr>
			<td style="width: 40%">
				<h2><g:message code="informations" /></h2>
				<g:render template="/player/profile" />
			</td>
			<td style="width: 40%">
				<h2><g:message code="statistics" /></h2>
				<div class="block" style="width: auto">
					<g:message code="player.stats.partCounter" /> :
					<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipations()}</span>
					<br />
					<!--span style="font-size: 14px"><g:message code="player.stats.partCounter.infos" /></span>
					<br /-->
					<br />
					<g:message code="player.stats.commentCounter" /> :
					<span style="font-size: 20px; font-weight: bold;">${playerInstance.countComments()}</span>
					<br />
					<br />
					<g:message code="registrationDate" default="Registration Date" /> :
					<g:formatDate date="${playerInstance?.registrationDate}" format="yyyy-MM-dd" />
					<br />
					<br />
					<g:message code="lastLogin" default="Last Login" /> :
					<g:if test="${playerInstance.lastLogin != null}">
						<flexy:humanDate date="${playerInstance.lastLogin.time}" />
					</g:if>
					<br />
					<br />
					<g:link action="stats" id="${playerInstance.id}"><g:message code="player.show.viewPlayerStats" /></g:link>
				</div>
			</td>
			<td style="width:20%; text-align: center;">
				<g:render template="/common/avatar" model="[player:playerInstance, width:'auto']" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<h2><g:message code="teams" /></h2>
				<table>
					<tr>
						<th colspan="2"><g:message code="name" /></th>
						<th><g:message code="training" />?</th>
						<th><g:message code="competition" />?</th>
					</tr>
					<g:each in="${playerInstance.memberships}" var="m">
						<g:form>
							<g:hiddenField name="id" value="${m.id}" />
							<tr style="height: 40px; border: solid black 0px;">
								<td style="vertical-align: middle; text-align: right; margin: 0px; padding: 0px">
									<g:set var="team" value="${m.team}" />
									<g:link controller="teams" action="show" id="${m.team.id}">
										<g:link controller="teams" action="show" id="${team.id}">
											<img style="max-width: 40px; max-height:40px;" src="${resource(dir:'images/team',file:team.logoName)}" alt="Team logo" />
										</g:link>
									</g:link>
								</td>
								<td style="vertical-align: middle; text-align: left">
									<g:link controller="teams" action="show" id="${m.team.id}">
										${team}
									</g:link>
								</td>
								<td style="vertical-align: middle;">
									${m.regularForTraining ? message(code:'regular') : message(code:'tourist')} 
								</td>
								<td style="vertical-align: middle;">
									${m.regularForCompetition ? message(code:'regular') : message(code:'tourist')}
								</td>
							</tr>
						</g:form>
					</g:each>
				</table>
			</td>
			<td>
				<h2><g:message code="skills" /></h2>
				<div class="block" style="width: auto">
					<g:if test="${playerInstance.skills.size() > 0}">
							<g:each in="${playerInstance.skills}" var="s">
								${s?.encodeAsHTML()}<br />
							</g:each>
					</g:if>
					<g:else>
						<i><g:message code="player.show.noSkills" /></i>
					</g:else>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<h2><g:message code="player.show.activity" /></h2>
				<g:set var="userParticipations" value="${playerInstance.getActiveParticipations(['max': (params.max ? params.max : 10), 'offset': params.offset])}" />
				<g:if test="${userParticipations.size() > 0}">
					<table>
						<tr>
							<th valign="top" rowspan="1"><g:message code="date" /></th>
							<th valign="top" rowspan="1"><g:message code="team" /></th>
							<th valign="top" rowspan="1"><g:message code="group" /></th>
							<th valign="top" rowspan="1"><g:message code="player.show.status" /></th>
							<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="wins" /></th>
							<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="draws" /></th>
							<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="defeats" /></th>
							<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="actions" /></th>
							<th style="font-size: 14px; text-align: right; vertical-align: middle;"><g:message code="votes" /></th>
						</tr>
						<g:render template="/player/participations" model="['userParticipations': userParticipations, 'withTotals': false]" />
					</table>
				</g:if>
				<g:else>
					<g:message code="player.show.noParticipations" />
				</g:else>
				<div class="pagination">
					<g:paginate total="${playerInstance.countAllActiveParticipations()}" id="${playerInstance.id}" />
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
