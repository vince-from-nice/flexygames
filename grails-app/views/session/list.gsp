
<%@ page import="flexygames.Session" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-session" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-session" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="date" title="${message(code: 'session.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="duration" title="${message(code: 'session.duration.label', default: 'Duration')}" />
					
						<g:sortableColumn property="rdvBeforeStart" title="${message(code: 'session.rdvBeforeStart.label', default: 'Rdv Before Start')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'session.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'session.description.label', default: 'Description')}" />
					
						<th><g:message code="session.playground.label" default="Playground" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sessionInstance.id}">${fieldValue(bean: sessionInstance, field: "date")}</g:link></td>
					
						<td>${fieldValue(bean: sessionInstance, field: "duration")}</td>
					
						<td>${fieldValue(bean: sessionInstance, field: "rdvBeforeStart")}</td>
					
						<td>${fieldValue(bean: sessionInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: sessionInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: sessionInstance, field: "playground")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sessionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
