<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${blogEntry.team.isManagedBy(session.currentUser?.username)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<h1 style="margin-top: 10px;">${blogEntry?.title}</h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	<div style="border: solid 1px; margin: 10px; padding: 10px; width: 500px;">
		<g:message code="team.show.blog.blogEntryOf" />
		<g:link controller="teams" action="show" id="${blogEntry.team.id}">${blogEntry.team}</g:link>
	</div>
	<div class="userBlogEntry">
		${blogEntry.body}
	</div>
	<div style="border: solid 1px; margin: 10px; padding: 10px; width: 500px;">
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
	<h2><g:message code="team.show.blog.comments" /></h2>
	<shiro:notUser>
		<p><b><g:message code="team.show.blog.comments.needLogin" /></b></p>
	</shiro:notUser>
	<shiro:user>
		<div style="text-align: left;">
			<g:form action="teams">
				<g:hiddenField name="id" value="${blogEntry.id}" />
				<g:textArea name="comment" value="" rows="4" cols="140" style="width: 600px; height: 100px" />
				<br />
				<g:actionSubmit class="save" action="postBlogComment" value="${message(code:'team.show.blog.comments.postComment')}" />
			</g:form>
		</div>
	</shiro:user>
	<br />
	<g:if test="${blogEntry.comments.size() > 0}">
		<g:each var="c" in="${blogEntry.comments}">
			<table style="width: auto;">
				<tr>
					<td>
						<a id="comment${c.id}"></a>
						<g:render template="/common/avatar" model="[player:c.user]" />
					</td>
					<td>
						<g:link controller="player" action="show" id="${c.user.id}"><i>${c.user}</i></g:link>
						<i> <g:message code="team.show.blog.comments.hasPosted" /> <flexy:humanDate date="${c.date.time}" />:</i><br />
						<br />
						${c.text}
					</td>
				</tr>
			</table>
			<br />
		</g:each>
	</g:if>
	<g:else>
		<i><g:message code="team.show.blog.comments.noComment" /></i><br />
	</g:else>
	<g:render template="/common/backLinks" />
  </body>
</html>
