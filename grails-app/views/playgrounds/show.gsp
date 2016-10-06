<!DOCTYPE html>
<%@ page import="flexygames.Team"%>
<html>
<head>
	<g:render template="/common/layout"/>
	<g:if test="${request.display != 'mobile'}">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
		<style type="text/css">
		html {
			height: 100%
		}
		body {
			height: 100%;
			margin: 0;
			padding: 0
		}
		#map_canvas {
			height: 100%
		}
		</style>
	</g:if>
	<script type="text/javascript"
			src="https://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=true">
	</script>
	<script type="text/javascript">
		function initializeGMap(lat, lon) {
			if (lat != null && lon != null) {
				var playgroundLatLon = new google.maps.LatLng(lat, lon);
				var myOptions = {
					center: playgroundLatLon,
					zoom: 13,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				};
				var infowindow = new google.maps.InfoWindow({
					content: "<h3 style='margin-top: Opx'>${playground}</h3>"
				});
				var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				var playgroundMarker = new google.maps.Marker({
					position: playgroundLatLon,
					map: map,
					title: "${playground}"
				});
				google.maps.event.addListener(playgroundMarker, 'click', function () {
					infowindow.open(map, playgroundMarker);
				});
				infowindow.open(map, playgroundMarker);
			} else {
				//alert("Bad coordinates !!");
			}
		}
	</script>
</head>
  <body onload="initializeGMap(${playground.latitude}, ${playground.longitude})">
	<h1>${playground}</h1>
	<table style="width: 100%; border: 0px">
		<tr>
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
			<td>
				<h2><g:message code="statistics" /></h2>
				<div class="block" style="width: auto">
					<g:message code="playground.show.sessionNbr" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${playground.sessions.size()}
					</span>
				</div>
			</td>
			<td>
				<h2><g:message code="playground.show.sessionGroups" /></h2>
				<g:message code="playground.show.sessionGroups.desc" /> :
				<g:if test="${playground.sessionGroups.size() > 0}">
				<ul>
				<g:each var="group" in="${playground.sessionGroups}">
					<li>
						<g:link controller="sessions" action="list" params="${['filteredSessionGroup':group.id]}">
							${group}
						</g:link>
					</li>
				</g:each>
				</ul>
				</g:if>
				<g:else>
					<i><g:message code="playground.show.sessionGroups.empty" /></i>
				</g:else>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: center;">
				<div id="map_canvas" style="width:95%; height:600px">
					<i><g:message code="playground.show.noCoordinates" /></i>
				</div>
			</td>
		</tr>
	</table>
	
  </body>
</html>