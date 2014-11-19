
<%@ page import="flexygames.Playground" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playground.label', default: 'Playground')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-playground" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-playground" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'playground.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'playground.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="street" title="${message(code: 'playground.street.label', default: 'Street')}" />
					
						<g:sortableColumn property="zip" title="${message(code: 'playground.zip.label', default: 'Zip')}" />
					
						<g:sortableColumn property="city" title="${message(code: 'playground.city.label', default: 'City')}" />
					
						<g:sortableColumn property="country" title="${message(code: 'playground.country.label', default: 'Country')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${playgroundInstanceList}" status="i" var="playgroundInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${playgroundInstance.id}">${fieldValue(bean: playgroundInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: playgroundInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: playgroundInstance, field: "street")}</td>
					
						<td>${fieldValue(bean: playgroundInstance, field: "zip")}</td>
					
						<td>${fieldValue(bean: playgroundInstance, field: "city")}</td>
					
						<td>${fieldValue(bean: playgroundInstance, field: "country")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${playgroundInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
