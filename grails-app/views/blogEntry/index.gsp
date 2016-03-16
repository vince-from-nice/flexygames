
<%@ page import="flexygames.BlogEntry" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'blogEntry.label', default: 'BlogEntry')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-blogEntry" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-blogEntry" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="blogEntry.user.label" default="User" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'blogEntry.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="text" title="${message(code: 'blogEntry.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'blogEntry.title.label', default: 'Title')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${blogEntryInstanceList}" status="i" var="blogEntryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${blogEntryInstance.id}">${fieldValue(bean: blogEntryInstance, field: "user")}</g:link></td>
					
						<td><g:formatDate date="${blogEntryInstance.date}" /></td>
					
						<td>${fieldValue(bean: blogEntryInstance, field: "text")}</td>
					
						<td>${fieldValue(bean: blogEntryInstance, field: "title")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${blogEntryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
