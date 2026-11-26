/*
 * Draws playgrounds on an OpenLayers map.
 *
 * places: [{name, address, url, lon, lat}]. Texts are put into the popup as text, never as HTML.
 * options.zoom: zoom used when there is a single place (default 15).
 * options.openPopup: open the popup of the first place on load.
 */
function flexyPlaygroundMap(targetId, places, options) {
	options = options || {};
	var target = document.getElementById(targetId);
	if (!target || typeof ol === 'undefined') {
		return null;
	}

	var popup = document.createElement('div');
	popup.className = 'ol-popup';
	var closer = document.createElement('a');
	closer.href = '#';
	closer.className = 'ol-popup-closer';
	closer.setAttribute('aria-label', 'Close');
	var content = document.createElement('div');
	popup.appendChild(closer);
	popup.appendChild(content);

	var features = places.map(function (place) {
		var feature = new ol.Feature({
			geometry: new ol.geom.Point(ol.proj.fromLonLat([place.lon, place.lat]))
		});
		feature.set('place', place);
		return feature;
	});
	var source = new ol.source.Vector({ features: features });

	var map = new ol.Map({
		target: target,
		layers: [
			new ol.layer.Tile({ source: new ol.source.OSM() }),
			new ol.layer.Vector({
				source: source,
				style: new ol.style.Style({
					image: new ol.style.Circle({
						radius: 8,
						fill: new ol.style.Fill({ color: '#1d4ed8' }),
						stroke: new ol.style.Stroke({ color: '#ffffff', width: 3 })
					})
				})
			})
		],
		view: new ol.View({
			center: ol.proj.fromLonLat([2.986875, 47.068327]),
			zoom: 6
		})
	});

	var overlay = new ol.Overlay({
		element: popup,
		autoPan: true,
		autoPanAnimation: { duration: 250 }
	});
	map.addOverlay(overlay);

	function showPopup(feature) {
		var place = feature.get('place');
		while (content.firstChild) {
			content.removeChild(content.firstChild);
		}
		var title = document.createElement(place.url ? 'a' : 'strong');
		title.className = 'ol-popup-title';
		title.textContent = place.name;
		if (place.url) {
			title.href = place.url;
		}
		content.appendChild(title);
		if (place.address) {
			var address = document.createElement('div');
			address.textContent = place.address;
			content.appendChild(address);
		}
		overlay.setPosition(feature.getGeometry().getCoordinates());
	}

	function hidePopup() {
		overlay.setPosition(undefined);
		closer.blur();
	}

	closer.addEventListener('click', function (event) {
		event.preventDefault();
		hidePopup();
	});

	map.on('singleclick', function (event) {
		var feature = map.forEachFeatureAtPixel(event.pixel, function (f) { return f; });
		if (feature) {
			showPopup(feature);
		} else {
			hidePopup();
		}
	});

	map.on('pointermove', function (event) {
		target.style.cursor = map.hasFeatureAtPixel(event.pixel) ? 'pointer' : '';
	});

	if (features.length === 1) {
		map.getView().setCenter(features[0].getGeometry().getCoordinates());
		map.getView().setZoom(options.zoom || 15);
	} else if (features.length > 1) {
		map.getView().fit(source.getExtent(), { padding: [48, 48, 48, 48], maxZoom: 13 });
	}

	if (options.openPopup && features.length > 0) {
		showPopup(features[0]);
	}
	return map;
}
