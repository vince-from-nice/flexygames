<script>
  var weatherCallbackFunction = function(data) {
	$(document).ready(function() {
		var c = data.query.results.channel

		// set location
		$("#meteoTitle").html(c.location.city);
		
		// set icon (url is extracted from description)
		var text = c.item.description;
		var i = text.indexOf('http://');
		var imageUrl = text.substring(i, text.indexOf('\"', i));
		$("#meteoImage").attr('src', imageUrl);
		
		// set infos
		$("#meteoInfos").html(c.item.condition.temp + '°' + c.units.temperature + ', ' + c.item.condition.text 
			+ '<br/>Wind: ' + c.wind.speed + ' ' + c.units.speed + ' ' + c.wind.direction + '°');
	});

  };
</script>

<script src="https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='${sessionInstance.playground.city}') and u='c'&format=json&callback=weatherCallbackFunction"></script>

<img id="meteoImage" src='' />
<div id='meteoTitle' style='font-size: small; font-weight: bold'></div>
<div id="meteoInfos" style='font-size: small'></div> 
