
<%@ page import="flexygames.BlogComment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'blogComment.label', default: 'BlogComment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-blogComment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-blogComment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="blogComment.user.label" default="User" /></th>
					
						<th><g:message code="blogComment.blogEntry.label" default="Blog Entry" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'blogComment.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="text" title="${message(code: 'blogComment.text.label', default: 'Text')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${blogCommentInstanceList}" status="i" var="blogCommentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${blogCommentInstance.id}">${fieldValue(bean: blogCommentInstance, field: "user")}</g:link></td>
					
						<td>${fieldValue(bean: blogCommentInstance, field: "blogEntry")}</td>
					
						<td><g:formatDate date="${blogCommentInstance.date}" /></td>
					
						<td>${fieldValue(bean: blogCommentInstance, field: "text")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${blogCommentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
