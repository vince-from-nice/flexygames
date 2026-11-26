<%@ page import="flexygames.Playground" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<link rel="stylesheet" href="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/css/ol.css" type="text/css">
	<link rel="stylesheet" href="${resource(dir:'css',file:'openlayers-popup.css')}" />
	<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
	<script src="${resource(dir:'js',file:'playground-map.js')}"></script>
</head>
<body>
	<div class="page-header">
		<h1><g:message code="playground.list.title" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<p class="muted"><g:message code="playground.list.intro" /></p>

	<div class="map-layout">
		<section class="card map-card">
			<div id="map_canvas" class="map"></div>
		</section>
		<section class="card">
			<div class="table-wrap">
				<table class="flexyTab">
					<thead>
						<tr>
							<g:sortableColumn property="city" title="${message(code: 'city', default: 'City')}" />
							<g:sortableColumn property="name" title="${message(code: 'name', default: 'Name')}" />
							<th class="number"><g:message code="sessions" /></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${playgroundInstanceList}" status="i" var="playgroundInstance">
							<g:set var="playgroundLink" value="${createLink(controller: 'playgrounds', action: 'show', id: playgroundInstance.id, absolute: true)}" />
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'} clickable" onclick="document.location='${playgroundLink}'">
								<td>${playgroundInstance.city}</td>
								<td><g:link action="show" id="${playgroundInstance.id}" class="player-name">${fieldValue(bean: playgroundInstance, field: "name")}</g:link></td>
								<td class="number"><span class="count-pill">${playgroundInstance.sessionsNbr}</span></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
			<div class="pagination">
				<g:paginate total="${playgroundInstanceTotal}" />
			</div>
		</section>
	</div>

	<script>
		flexyPlaygroundMap('map_canvas', [
			<g:each in="${playgroundInstanceList.findAll { it.latitude != null && it.longitude != null }}" var="p">
			{name: '${p.name?.encodeAsJavaScript()}', address: '${p.postalAddress?.encodeAsJavaScript()}', url: '${createLink(controller: 'playgrounds', action: 'show', id: p.id).encodeAsJavaScript()}', lon: ${p.longitude}, lat: ${p.latitude}},
			</g:each>
		]);
	</script>
</body>
</html>
