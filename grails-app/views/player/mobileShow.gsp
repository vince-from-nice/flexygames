
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<table style="width: 100%; border: 0px">
		<tr>
			<td style="">
				<h1>${fieldValue(bean: playerInstance, field: "username")}</h1>
				<g:render template="/common/avatar" model="[player:playerInstance, width:'auto']" />
			</td>
			<td style="">
				<h2><g:message code="informations" /></h2>
				<g:render template="/player/profile" />
			</td>
		</tr>
		<tr>
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
			<td style="">
				<h2><g:message code="statistics" /></h2>
				<div class="block" style="width: auto">
					<g:message code="player.stats.partCounter" /> :
					<span style="font-size: 20px; font-weight: bold;">${playerInstance.countParticipations()}</span>
					<br />
					%{--<span style="font-size: 14px"><g:message code="player.stats.partCounter.infos" /></span>--}%
					%{--<br />--}%
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
		</tr>
		<tr>
			<td colspan="2">
				<h2><g:message code="teams" /></h2>
				<g:render template="memberships" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<h2><g:message code="player.show.activity" /></h2>
				<g:set var="userParticipations" value="${playerInstance.getActiveParticipations(['max': (params.max ? params.max : 10), 'offset': params.offset])}" />
				<g:if test="${userParticipations.size() > 0}">
					<table>
						<tr>
							<th valign="top" rowspan="1"><g:message code="date" /></th>
							<th valign="top" rowspan="1"><g:message code="team" /></th>
							<th valign="top" rowspan="1"><g:message code="group" /></th>
							<th valign="top" rowspan="1"><g:message code="player.show.status" /></th>
						</tr>
						<g:render template="/player/participations" model="['userParticipations': userParticipations, 'withTotals': false, 'withAllCols':false]" />
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
