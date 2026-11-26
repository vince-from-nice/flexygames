<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${teamInstance.isManagedBy(request.currentUser?.username)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>

	<section class="card team-hero">
		<div class="team-hero-logo">
			<flexy:teamLogo team="${teamInstance}" size="large" />
		</div>
		<div class="team-hero-info">
			<h1>${teamInstance}</h1>
			<dl class="facts">
				<g:if test="${teamInstance.city}">
					<div><dt><g:message code="city" default="City" /></dt><dd>${fieldValue(bean: teamInstance, field: "city")}</dd></div>
				</g:if>
				<g:if test="${teamInstance.webUrl}">
					<div><dt><g:message code="webUrl" default="Web Url" /></dt><dd><g:link url="${teamInstance.webUrl}">${fieldValue(bean: teamInstance, field: "webUrl")}</g:link></dd></div>
				</g:if>
				<div>
					<dt><g:message code="managers" default="Manager(s)" /></dt>
					<dd><g:each in="${teamInstance.managers}" var="m" status="i">${i > 0 ? ', ' : ''}<g:link controller="player" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></g:each></dd>
				</div>
			</dl>
		</div>
		<g:if test="${teamIsManagedByCurrentUser}">
			<g:form controller="fileUpload" action="process" method="post" enctype="multipart/form-data" class="upload-form team-logo-upload">
				<g:hiddenField name="uploadType" value="teamLogo" />
				<g:hiddenField name="id" value="${teamInstance.id}" />
				<g:hiddenField name="errorAction" value="changeTeamLogoError" />
				<g:hiddenField name="errorController" value="manager" />
				<g:hiddenField name="successAction" value="changeTeamLogoSuccess" />
				<g:hiddenField name="successController" value="manager" />
				<label for="teamLogoFile" class="muted small"><g:message code="team.show.uploadLogo" /></label>
				<input type="file" id="teamLogoFile" name="file" accept="image/jpeg,image/png,image/gif" />
				<input type="submit" name="submit" value="${message(code: 'default.button.upload.label', default: 'Upload')}" />
			</g:form>
		</g:if>
	</section>

	<div class="stat-tiles">
		<div class="stat-tile"><strong>${teamInstance.members.size()}</strong><span><g:message code="team.stats.totalOfMembers" /></span></div>
		<div class="stat-tile"><strong>${teamInstance.countSessions()}</strong><span><g:message code="team.stats.totalOfSessions" /></span></div>
		<div class="stat-tile"><strong>${teamInstance.countAllEffectiveSessions()}</strong><span><g:message code="team.stats.totalOfEffectiveSessions" /></span></div>
		<div class="stat-tile"><strong>${teamInstance.countAllParticipations()}</strong><span><g:message code="team.stats.totalOfParticipations" /></span></div>
		<div class="stat-tile"><strong>${teamInstance.countAllEffectiveParticipations()}</strong><span><g:message code="team.stats.totalOfEffectiveParticipations" /></span></div>
	</div>

	<nav class="tabs">
		<g:each in="${[['blog', 'blog'], ['training', 'trainings'], ['competition', 'competitions'], ['members', 'members'], ['ranking', 'rankings']]}" var="tab">
			<g:link action="show" id="${teamInstance.id}" params="[mode: tab[0]]" class="${params.mode == tab[0] ? 'active' : ''}"><g:message code="${tab[1]}" /></g:link>
		</g:each>
	</nav>

	<section class="card tab-panel">
		<g:if test="${params.mode=='blog'}">
			<g:render template="showBlog" />
		</g:if>
		<g:if test="${params.mode=='competition' || params.mode=='training' }">
			<g:render template="showSessions" />
		</g:if>
		<g:if test="${params.mode=='members'}">
			<g:render template="showMembers" />
		</g:if>
		<g:if test="${params.mode=='ranking'}">
			<g:render template="showRanking" />
		</g:if>
	</section>

	<g:render template="/common/backLinks" />
</body>
</html>
