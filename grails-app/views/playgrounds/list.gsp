<%@ page import="flexygames.Playground" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<g:render template="/common/layout" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
		<link rel="stylesheet" href="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/css/ol.css" type="text/css">
		<link rel="stylesheet" href="${resource(dir:'css',file:'openlayers-popup.css')}" />
		<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="playground.list.title" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <p><g:message code="playground.list.intro" /></p>
			<br />
			<table style="width: 100%; height:100%; border: 0px">
				<tr>
					<td style="width:70%; height:100%">
						<div id="map_canvas" >
							<div id="popup" class="ol-popup">
								<a href="#" id="popup-closer" class="ol-popup-closer"></a>
								<div id="popup-content"></div>
							</div>
						</div>
					</td>
					<td>
						<table class="flexyTab">
							<thead>
								<tr>
									<g:sortableColumn property="city" title="${message(code: 'city', default: 'City')}" />
									<g:sortableColumn property="name" title="${message(code: 'name', default: 'Name')}" />
									<th style="text-align: left;"><g:message code="sessions" /></th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${playgroundInstanceList}" status="i" var="playgroundInstance">
									<g:set var="playgroundLink"
										value="${createLink(controller: 'playgrounds', action: 'show', id: playgroundInstance.id, absolute: true)}" />
									<tr class="${(i % 2) == 0 ? 'odd' : 'even'}"
										style="height: 50px; cursor: pointer"
										onclick="document.location='${playgroundLink}'">
										<td style="text-align: left; vertical-align: middle;">
											${playgroundInstance.city}
										</td>
										<td style="text-align: left; vertical-align: middle;">
											<b>${fieldValue(bean: playgroundInstance, field: "name")}</b>
										</td>
										<td style="text-align: right; vertical-align: middle;">${playgroundInstance.sessionsNbr}</td>
									</tr>
								</g:each>
							</tbody>
						</table>
						<div class="pagination">
							<g:paginate total="${playgroundInstanceTotal}" />
						</div>
					</td>
				</tr>
			</table>
		</div>
	<script>
		// Create the map
		const map = new ol.Map({
			target: 'map_canvas',
			layers: [
				new ol.layer.Tile({
					source: new ol.source.OSM()
				})
			],
			view: new ol.View({
				projection: 'EPSG:3857',
				center: ol.proj.transform([2.986875, 47.068327], 'EPSG:4326', 'EPSG:3857'),
				zoom: 6
			})
		});

		// Add markers
		var markers = [];
		// var marker_style = {
		// 	'stroke-width': 10,
		// 	'stroke-color': '#ff0000'
		// };
		var marker_style = new ol.style.Style({
			stroke: new ol.style.Stroke({
				color: 'green',
				width: 3
			}),
			fill: new ol.style.Fill({
				color: '#ff0000'
			})
		});
		<g:each in="${playgroundInstanceList}" status="i" var="p">
			var marker = new ol.Feature({geometry: new ol.geom.Point(ol.proj.fromLonLat([${p.longitude}, ${p.latitude}])), name: "${p.name}"});
			marker.name = "${p.name}";
			marker.description = "${p.postalAddress}"
			marker.style = marker_style;
			//marker.setStyle(marker_style);
			markers.push(marker);
		</g:each>
		var layer = new ol.layer.Vector({
			source: new ol.source.Vector({
				features: markers
			})
		});
		map.addLayer(layer);

		// Initialize the popup
		var container = document.getElementById('popup');
		var content = document.getElementById('popup-content');
		var closer = document.getElementById('popup-closer');

		var overlay = new ol.Overlay({
			element: container,
			autoPan: true,
			autoPanAnimation: {
				duration: 250
			}
		});
		map.addOverlay(overlay);

		closer.onclick = function() {
			overlay.setPosition(undefined);
			closer.blur();
			return false;
		};

		// Add the function to open the popup when you click on the marker
		map.on('singleclick', function (event) {
			if (map.hasFeatureAtPixel(event.pixel) === true) {
				const hit = map.forEachFeatureAtPixel(event.pixel, (feature) => {
					var coordinate = event.coordinate;
					content.innerHTML = "<b>" + feature.name + "</b><br>" + feature.description;
					overlay.setPosition(coordinate);
				});
			} else {
				overlay.setPosition(undefined);
				closer.blur();
			}
		});
	</script>
    </body>
</html>
