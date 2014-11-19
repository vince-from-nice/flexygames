
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
	};
	var chart = new google.visualization.PieChart(document.getElementById(divId));
	chart.draw(data, options);
}

function drawGColumnChart(title, divId, input, width, height, valueType) {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Player');
	data.addColumn('number', valueType);
	data.addRows(input);
	var options = {
		title : title,
		width : width,
		height : height,
		dataOpacity : 0.4,
		hAxis : {minValue : "0"},
		vAxis : {minValue : "0"},
	};
	var chart = new google.visualization.ColumnChart(document.getElementById(divId));
	chart.draw(data, options);
}