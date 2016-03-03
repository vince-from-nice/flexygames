
google.load('visualization', '1.0', {
	'packages' : [ 'corechart' ]
});


function drawGPieChart(title, divId, input, width, height) {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Player');
	data.addColumn('number', 'Value');
	data.addRows(input);
	var options = {
		'title' : title,
		'width' : width,
		'height' : height,
		'pieSliceText' : 'value',
		'is3D' : true,
		'titleTextStyle' : {fontSize: 14, bold: true},
		'legend' : {position: 'right', textStyle: {fontSize: 10}},
		'chartArea' : {width: "100%", height: "80%"}
	};
	var chart = new google.visualization.PieChart(document.getElementById(divId));
	chart.draw(data, options);
}

function drawGColumnChart(title, divId, input, width, height, valueType) {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Player');
	//data.addColumn('number', 'id');
	data.addColumn('number', valueType);
	data.addRows(input);
	var options = {
		title : title,
		width : width,
		height : height,
		dataOpacity : 0.4,
		hAxis : {minValue : "0"},
		vAxis : {minValue : "0"},
		//click : '/player/show/${targetID}'
	};
	var chart = new google.visualization.ColumnChart(document.getElementById(divId));
	chart.draw(data, options);

	//// a click handler which grabs some values then redirects the page
	//google.visualization.events.addListener(chart, 'select', function() {
	//	// grab a few details before redirecting
	//	var selection = chart.getSelection();
	//	var row = selection[0].row;
	//	var col = selection[0].column;
	//	var id = data.getValue(row, 0);
	//	location.href = '/player/show/' + id;
	//});
}
