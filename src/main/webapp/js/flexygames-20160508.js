function toggleDisplay(id) {
	doc = document.getElementById(id)
	if (doc.style.display == 'block') {
		doc.style.display = 'none';
	} else {
		doc.style.display = 'block';
	}
}

function toggleTableDisplay(id) {
	doc = document.getElementById(id)
	if (doc.style.display == 'table') {
		doc.style.display = 'none';
	} else {
		doc.style.display = 'table';
	}
}

function toggleRowDisplay(id) {
	doc = document.getElementById(id)
	if (doc.style.display == 'table-row') {
		doc.style.display = 'none';
	} else {
		doc.style.display = 'table-row';
	}
}

function togglePendingParticipations() {
	for (var i = 0; i < pendingParticipationIds.length; i++) {
		var id = pendingParticipationIds[i];
		//console.log('toggling participation-' + id);
		var player = document.getElementById('participation-' + id);
		if (player.style.display == 'table-row') {
			player.style.display = 'none';
		} else {
			player.style.display = 'table-row';
		}
	}
}

function detectBadBrowser() {
	var ua = navigator.userAgent.toLowerCase();
	return ua.indexOf("msie") > -1
}

//var detect = navigator.userAgent.toLowerCase();
//var OS,browser,version,thestring;
//
//function detectBrowser() {
//
//	if (checkIt('konqueror'))
//	{
//		browser = "Konqueror";
//		OS = "Linux";
//	}
//	else if (checkIt('safari')) browser = "Safari"
//	else if (checkIt('omniweb')) browser = "OmniWeb"
//	else if (checkIt('opera')) browser = "Opera"
//	else if (checkIt('webtv')) browser = "WebTV";
//	else if (checkIt('icab')) browser = "iCab"
//	else if (checkIt('msie')) browser = "Internet Explorer"
//	else if (!checkIt('compatible'))
//	{
//		browser = "Netscape Navigator"
//		version = detect.charAt(8);
//	}
//	else browser = "An unknown browser";
//
//	if (!version) version = detect.charAt(place + thestring.length);
//
//	if (!OS)
//	{
//		if (checkIt('linux')) OS = "Linux";
//		else if (checkIt('x11')) OS = "Unix";
//		else if (checkIt('mac')) OS = "Mac"
//		else if (checkIt('win')) OS = "Windows"
//		else OS = "an unknown operating system";
//	}
//}
//
//function checkIt(string)
//{
//	place = detect.indexOf(string) + 1;
//	thestring = string;
//	return place;
//}

