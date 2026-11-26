<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="myPlanning.title" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<section class="card prose">
		<p><g:message code="myPlanning.text1" /></p>
		<p><g:message code="myPlanning.text2" /></p>
		<p><g:message code="myPlanning.text3" /></p>
		<g:set var="calendarUrl" value="${grailsApplication.config.grails.serverURL}/player/cal/${player.id}?token=${player.calendarToken}" />
		<p class="copy-box"><a href="${calendarUrl}">${calendarUrl}</a></p>
		<p><g:message code="myPlanning.text4" /></p>
	</section>
</body>
</html>
