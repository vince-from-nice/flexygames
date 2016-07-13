<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${blogEntry.team.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<h1>
		<g:message code="team.show.blog.blogEntryOf" />
		<g:link controller="teams" action="show" id="${blogEntry.team.id}">${blogEntry.team}</g:link>
	</h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:message code="team.show.blog.postedBy" />
	<g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
	<flexy:humanDate date="${blogEntry.date.time}" />
	<br>
	<g:if test="${blogEntry.lastUpdater}">
		<g:message code="team.show.blog.updatedBy" />
		<g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
		<flexy:humanDate date="${blogEntry.lastUpdate.time}" />
		<br>
	</g:if>
	<div class="userBlogEntry">
		<h2 style="margin-top: 0px;">${blogEntry?.title}</h2>
		${blogEntry.body}
	</div>
	<g:render template="/common/backLinks" />
  </body>
</html>
