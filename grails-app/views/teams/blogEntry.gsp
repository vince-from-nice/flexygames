<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${blogEntry.team.isManagedBy(request.currentUser?.username)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<p class="breadcrumb"><g:message code="team.show.blog.blogEntryOf" /> <g:link controller="teams" action="show" id="${blogEntry.team.id}">${blogEntry.team}</g:link></p>
	<div class="page-header">
		<h1>${blogEntry?.title?.encodeAsHTML()}</h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	<article class="card blog-article">
		<p class="small muted">
			<g:message code="team.show.blog.postedBy" />
			<g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
			<flexy:humanDate date="${blogEntry.date.time}" />
			<g:if test="${blogEntry.lastUpdater}">
				·
				<g:message code="team.show.blog.updatedBy" />
				<g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
				<flexy:humanDate date="${blogEntry.lastUpdate.time}" />
			</g:if>
		</p>
		<div class="blog-entry-body">${blogEntry.body}</div>
	</article>
	<section class="card">
		<h2><g:message code="team.show.blog.comments" /></h2>
		<shiro:notUser>
			<p class="muted"><g:message code="team.show.blog.comments.needLogin" /></p>
		</shiro:notUser>
		<shiro:user>
			<g:form action="teams" class="comment-form">
				<g:hiddenField name="id" value="${blogEntry.id}" />
				<g:textArea name="comment" value="" rows="4" aria-label="${message(code: 'team.show.blog.comments')}" />
				<g:actionSubmit class="save" action="postBlogComment" value="${message(code:'team.show.blog.comments.postComment')}" />
			</g:form>
		</shiro:user>
		<g:if test="${blogEntry.comments.size() > 0}">
			<ol class="comment-list">
				<g:each var="c" in="${blogEntry.comments}">
					<li class="comment" id="comment${c.id}">
						<div class="avatar-cell"><g:render template="/common/avatar" model="[player: c.user]" /></div>
						<div class="comment-body">
							<p class="comment-meta">
								<g:link controller="player" action="show" id="${c.user.id}" class="player-name">${c.user}</g:link>
								<span class="muted"><g:message code="team.show.blog.comments.hasPosted" /> <flexy:humanDate date="${c.date.time}" /></span>
							</p>
							<div class="comment-text">${c.text}</div>
						</div>
					</li>
				</g:each>
			</ol>
		</g:if>
		<g:else>
			<p class="muted"><g:message code="team.show.blog.comments.noComment" /></p>
		</g:else>
	</section>
	<g:render template="/common/backLinks" />
</body>
</html>
