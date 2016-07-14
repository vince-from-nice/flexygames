<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${blogEntry.team.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div style="border: solid green 1px; padding: 10px; width: auto">
		<h2 style="margin-top: 0px;">
			<g:message code="team.show.blog.blogEntryOf" />
			<g:link controller="teams" action="show" id="${blogEntry.team.id}">${blogEntry.team}</g:link>
		</h2>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<div class="userBlogEntryzzz">
		<h1 style="margin-top: 10px;">${blogEntry?.title}</h1>
		${blogEntry.body}
	</div>
	<br>
	<div style="border: solid green 1px; padding: 10px; width: auto">
		<g:message code="team.show.blog.postedBy" />
		<g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
		<flexy:humanDate date="${blogEntry.date.time}" />
		<g:if test="${blogEntry.lastUpdater}">
			|
			<g:message code="team.show.blog.updatedBy" />
			<g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
			<flexy:humanDate date="${blogEntry.lastUpdate.time}" />
			<br>
		</g:if>
	</div>
	<g:render template="/common/backLinks" />
  </body>
</html>
