<%@ page import="flexygames.Playground" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<g:render template="/common/layout" />
        <g:set var="entityName" value="${message(code: 'playground.label', default: 'Team')}" />
	    <style type="text/css">
	      html { height: 100% }
	      body { height: 100%; margin: 0; padding: 0 }
	      #map_canvas { height: 100% }
	    </style>
	    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=true">
	    </script>
	    <script type="text/javascript">
	      function initializeGMap(lat, lon) {
			var centerOfFranceLatLon = new google.maps.LatLng(47.068327, 2.986875);
	        var myOptions = {
	          center: centerOfFranceLatLon,
	          zoom: 6,
	          mapTypeId: google.maps.MapTypeId.ROADMAP
	        };
	        var map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
	        var body = '';
			<g:each in='${playgroundInstanceList}' var='playground'>
				body = "${playground.postalAddress}";
				<g:if test="${playground.phoneNumber}">
					body = body + "<br>Telephone: ${playground.phoneNumber}";
				</g:if>
				<g:if test="${playground.websiteUrl}">
					body = body + "<br>Web: <a href='${playground.websiteUrl}''>${playground.websiteUrl}</a>";
				</g:if>		
				addMarker(map, "${playground}", ${playground.latitude}, ${playground.longitude}, body);
			</g:each>
	      }
	      function addMarker(map, title, lat, lon, body) {
	    	  	var playgroundLatLon = new google.maps.LatLng(lat, lon);
		        var playgroundMarker = new google.maps.Marker({position: playgroundLatLon, map: map, title:"${playground}"});
		        var infowindow = new google.maps.InfoWindow({
		            content: "<h3 style='margin-top: Opx'>" + title + "</h3><br/><p>" + body + "</p>"
		        });
		        google.maps.event.addListener(playgroundMarker, 'click', function() {
		        	  infowindow.open(map, playgroundMarker);
		        	});
		  }
	    </script>
    </head>
    <body onload="initializeGMap()">
        <div class="body">
            <h1><g:message code="playground.list.title" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <p><g:message code="playground.list.intro" /></p>
			<br />	
			<div id="map_canvas" style="width:95%; height:500px">
				<i><g:message code="playground.show.noCoordinates" /></i>
			</div>
			<br />
			<table class="flexyTab">
				<thead>
					<tr>
						<g:sortableColumn property="city" title="${message(code: 'city', default: 'City')}" />
						<g:sortableColumn property="name" title="${message(code: 'name', default: 'Name')}" />
						<th style="text-align: right;"><g:message code="playground.list.sessionNbr" /></th>
						<!--th style="text-align: left;"><g:message code="playground.list.sessionGroup" /></th-->
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
							<td style="text-align: right; vertical-align: middle;"><b> ${playgroundInstance.sessions.size()}</td>
							<!--td style="text-align: left; vertical-align: middle; font-size: 12px">
								<g:each var="group" in="${playgroundInstance.sessionGroups}">
									<g:link controller="sessions" action="list" params="${['filteredSessionGroup':group.id]}">
										${group}
									</g:link>
									<br />
								</g:each>
							</td-->
						</tr>
					</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${playgroundInstanceTotal}" />
			</div>
		</div>
    </body>
</html>
