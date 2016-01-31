
<%@ page import="flexygames.Team" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-team" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-team" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
				<div class="errors">${flash.error}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'team.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'team.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="city" title="${message(code: 'team.city.label', default: 'City')}" />
					
						<g:sortableColumn property="webUrl" title="${message(code: 'team.webUrl.label', default: 'Web Url')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'team.email.label', default: 'Email')}" />
					
						<th><g:message code="team.logo.label" default="Logo" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${teamInstanceList}" status="i" var="teamInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${teamInstance.id}">${fieldValue(bean: teamInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: teamInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: teamInstance, field: "city")}</td>
					
						<td>${fieldValue(bean: teamInstance, field: "webUrl")}</td>
					
						<td>${fieldValue(bean: teamInstance, field: "email")}</td>
					
						<td>${fieldValue(bean: teamInstance, field: "logoName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${teamInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
