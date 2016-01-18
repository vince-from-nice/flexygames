
<%@ page import="flexygames.SessionComment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionComment.label', default: 'SessionComment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sessionComment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sessionComment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="sessionComment.user.label" default="User" /></th>
					
						<th><g:message code="sessionComment.session.label" default="Session" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'sessionComment.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="text" title="${message(code: 'sessionComment.text.label', default: 'Text')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sessionCommentInstanceList}" status="i" var="sessionCommentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sessionCommentInstance.id}">${fieldValue(bean: sessionCommentInstance, field: "user")}</g:link></td>
					
						<td>${fieldValue(bean: sessionCommentInstance, field: "session")}</td>
					
						<td><g:formatDate date="${sessionCommentInstance.date}" /></td>
					
						<td>${fieldValue(bean: sessionCommentInstance, field: "text")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sessionCommentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
