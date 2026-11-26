<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<title>${fieldValue(bean: playerInstance, field: "username")}</title>
</head>
<body>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>

	<section class="card profile-hero">
		<span class="profile-avatar"><g:render template="/common/avatar" model="[player: playerInstance, width: '96px']" /></span>
		<div class="profile-identity">
			<h1>${fieldValue(bean: playerInstance, field: "username")}</h1>
			<p class="muted small">
				<g:message code="registrationDate" default="Registration Date" />: <g:formatDate date="${playerInstance?.registrationDate}" format="yyyy-MM-dd" />
				<g:if test="${playerInstance.lastLogin != null}">
					· <g:message code="lastLogin" default="Last Login" />: <flexy:humanDate date="${playerInstance.lastLogin.time}" />
				</g:if>
			</p>
		</div>
		<g:link action="stats" id="${playerInstance.id}" class="btn"><g:message code="player.show.viewPlayerStats" /></g:link>
	</section>

	<div class="stat-tiles">
		<div class="stat-tile">
			<strong>${playerInstance.participationCounter ?: 0}</strong>
			<span><g:message code="player.stats.partCounter" /></span>
		</div>
		<div class="stat-tile">
			<strong>${playerInstance.votingScoreCounter ?: 0}</strong>
			<span><g:message code="player.stats.votingScoreCounter" /></span>
		</div>
		<div class="stat-tile">
			<strong>${playerInstance.commentCounter ?: 0}</strong>
			<span><g:message code="player.stats.commentCounter" /></span>
		</div>
	</div>

	<div class="account-grid">
		<section class="card">
			<h2><g:message code="informations" /></h2>
			<g:render template="/player/profile" />
		</section>
		<div>
			<section class="card">
				<h2><g:message code="teams" /></h2>
				<g:render template="memberships" />
			</section>
			<section class="card">
				<h2><g:message code="skills" /></h2>
				<g:if test="${playerInstance.skills.size() > 0}">
					<div class="chips">
						<g:each in="${playerInstance.skills}" var="s"><span class="chip">${s?.encodeAsHTML()}</span></g:each>
					</div>
				</g:if>
				<g:else>
					<p class="muted"><g:message code="player.show.noSkills" /></p>
				</g:else>
			</section>
		</div>
	</div>

	<section class="card">
		<h2><g:message code="player.show.activity" /></h2>
		<g:set var="userParticipations" value="${playerInstance.getActiveParticipations(['max': (params.max ? params.max : 10), 'offset': params.offset])}" />
		<g:if test="${userParticipations.size() > 0}">
			<div class="table-wrap">
				<table class="flexyTab">
					<tr>
						<th><g:message code="date" /></th>
						<th><g:message code="team" /></th>
						<th><g:message code="group" /></th>
						<th class="status-head"><g:message code="player.show.status" /></th>
						<th class="number"><g:message code="wins" /></th>
						<th class="number"><g:message code="draws" /></th>
						<th class="number"><g:message code="defeats" /></th>
						<th class="number"><g:message code="actions" /></th>
						<th class="number"><g:message code="votes" /></th>
					</tr>
					<g:render template="/player/participations" model="['userParticipations': userParticipations, 'withTotals': false, 'withAllCols': true]" />
				</table>
			</div>
		</g:if>
		<g:else>
			<p class="muted"><g:message code="player.show.noParticipations" /></p>
		</g:else>
		<div class="pagination">
			<g:paginate total="${playerInstance.countAllActiveParticipations()}" id="${playerInstance.id}" />
		</div>
	</section>
</body>
</html>
