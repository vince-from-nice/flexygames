<!DOCTYPE html>
<%@ page import="flexygames.Team"%>
<html>
<head>
	<g:render template="/common/layout"/>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
	<link rel="stylesheet" href="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/css/ol.css" type="text/css">
	<link rel="stylesheet" href="${resource(dir:'css',file:'openlayers-popup.css')}" />
	<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
</head>
  <body onload="">
	<h1><g:link controller="playgrounds" action="list"><g:message code="playground.list.title" /></g:link> : ${playground}</h1>
	<table style="width: 100%; border: 0px">
		<tr>
			<td rowspan="3" style="width:80%; height:auto">
				<div id="map_canvas" >
					<div id="popup" class="ol-popup">
						<a href="#" id="popup-closer" class="ol-popup-closer"></a>
						<div id="popup-content"></div>
					</div>
				</div>
			</td>
			<td>
				<h2><g:message code="informations" /></h2>
				<div class="block" style="width: auto">
					<g:if test="${flash.message}">
						<div class="message">
							${flash.message}
						</div>
					</g:if>
					<p>${playground?.postalAddress}</p>
					<g:if test="${playground?.phoneNumber}"><p><g:message code="phoneNumber" /> : ${playground?.phoneNumber}</p></g:if>
					<g:if test="${playground?.websiteUrl}">
						<p><g:message code="webUrl" /> : <g:link url="${playground?.websiteUrl}">${playground?.websiteUrl}</g:link></p>
					</g:if>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<h2><g:message code="statistics" /></h2>
				<div class="block" style="width: auto">
					<g:message code="playground.show.sessionNbr" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${playground.sessions.size()}
					</span>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<h2><g:message code="playground.show.teams" /></h2>
				<g:message code="playground.show.teams.desc" /> :
				<g:if test="${playground.sessionGroups.size() > 0}">
				<ul>
				<g:each var="team" in="${playground.sessionGroups*.defaultTeams.toSet()}">
					<li>
						<g:link controller="teams" action="show" params="${['id':team.id]}">
							${team}
						</g:link>
					</li>
				</g:each>
				</ul>
				</g:if>
				<g:else>
					<i><g:message code="playground.show.teams.empty" /></i>
				</g:else>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: center;">

			</td>
		</tr>
	</table>
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
			  center: ol.proj.transform([${playground.longitude}, ${playground.latitude}], 'EPSG:4326', 'EPSG:3857'),
			  zoom: 15
		  })
	  });

	  // Add a marker
	  var layer = new ol.layer.Vector({
		  source: new ol.source.Vector({
			  features: [
				  new ol.Feature({
					  geometry: new ol.geom.Point(ol.proj.fromLonLat([${playground.longitude}, ${playground.latitude}]))
				  })
			  ]
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
			  var coordinate = event.coordinate;
			  content.innerHTML = "<b>${playground.name}</b><br>${playground.postalAddress}";
			  overlay.setPosition(coordinate);
		  } else {
			  overlay.setPosition(undefined);
			  closer.blur();
		  }
	  });
	  content.innerHTML = "<b>${playground.name}</b><br>${playground.postalAddress}";
	  overlay.setPosition(ol.proj.fromLonLat([${playground.longitude}, ${playground.latitude}]));
  </script>
  </body>
</html>