
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<h1><g:message code="myPlanning.title" /></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<p>
		<g:message code="myPlanning.text1" />
	</p>
	<br />
	<p>
		<g:message code="myPlanning.text2" />
	</p>
	<br />
	<g:message code="myPlanning.text3" />
	<div class="block" style="width: auto; ">
		<a href="${grailsApplication.config.grails.serverURL}/player/cal/${player.id}?token=${player.calendarToken}">
			${grailsApplication.config.grails.serverURL}/player/cal/${player.id}?token=${player.calendarToken}
		</a>
	</div>
	<br />
	<p>
		<g:message code="myPlanning.text4" />
	</p>
</body>
</html>
