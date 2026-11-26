<!DOCTYPE html>
<%@ page import="flexygames.Team"%>
<html>
<head>
	<g:render template="/common/layout"/>
	<link rel="stylesheet" href="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/css/ol.css" type="text/css">
	<link rel="stylesheet" href="${resource(dir:'css',file:'openlayers-popup.css')}" />
	<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
	<script src="${resource(dir:'js',file:'playground-map.js')}"></script>
</head>
<body>
	<g:set var="hasPosition" value="${playground.latitude != null && playground.longitude != null}" />
	<p class="breadcrumb"><g:link controller="playgrounds" action="list"><g:message code="playground.list.title" /></g:link></p>
	<div class="page-header">
		<h1>${playground}</h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>

	<div class="map-layout">
		<section class="card map-card">
			<g:if test="${hasPosition}">
				<div id="map_canvas" class="map"></div>
			</g:if>
			<g:else>
				<p class="map-empty muted"><g:message code="playground.show.noCoordinates" /></p>
			</g:else>
		</section>

		<div class="side-stack">
			<section class="card">
				<h2><g:message code="informations" /></h2>
				<dl class="facts">
					<div>
						<dt><g:message code="address" /></dt>
						<dd>${playground.postalAddress}</dd>
					</div>
					<g:if test="${playground.phoneNumber}">
						<div>
							<dt><g:message code="phoneNumber" /></dt>
							<dd>${playground.phoneNumber}</dd>
						</div>
					</g:if>
					<g:if test="${playground.websiteUrl}">
						<div>
							<dt><g:message code="webUrl" /></dt>
							<dd><g:link url="${playground.websiteUrl}">${playground.websiteUrl}</g:link></dd>
						</div>
					</g:if>
				</dl>
			</section>

			<div class="stat-tile">
				<strong>${playground.sessions.size()}</strong>
				<span><g:message code="playground.show.sessionNbr" /></span>
			</div>

			<section class="card">
				<h2><g:message code="playground.show.teams" /></h2>
				<p class="small muted"><g:message code="playground.show.teams.desc" /></p>
				<g:if test="${playground.sessionGroups.size() > 0}">
					<ul class="team-list">
						<g:each var="team" in="${playground.sessionGroups*.defaultTeams.flatten().toSet()}">
							<li>
								<g:link controller="teams" action="show" id="${team.id}" title="${team}"><flexy:teamLogo team="${team}" /></g:link>
								<g:link controller="teams" action="show" id="${team.id}">${team}</g:link>
							</li>
						</g:each>
					</ul>
				</g:if>
				<g:else>
					<p class="muted"><g:message code="playground.show.teams.empty" /></p>
				</g:else>
			</section>
		</div>
	</div>

	<g:if test="${hasPosition}">
		<script>
			flexyPlaygroundMap('map_canvas', [
				{name: '${playground.name?.encodeAsJavaScript()}', address: '${playground.postalAddress?.encodeAsJavaScript()}', lon: ${playground.longitude}, lat: ${playground.latitude}}
			], {zoom: 15, openPopup: true});
		</script>
	</g:if>
</body>
</html>
