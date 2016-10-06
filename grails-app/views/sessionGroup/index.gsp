
<%@ page import="flexygames.SessionGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'sessionGroup.label', default: 'SessionGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sessionGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sessionGroup" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'sessionGroup.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'sessionGroup.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="competition" title="${message(code: 'sessionGroup.competition.label', default: 'Competition')}" />
					
						<g:sortableColumn property="visible" title="${message(code: 'sessionGroup.visible.label', default: 'Visible')}" />
					
						<th><g:message code="sessionGroup.defaultType.label" default="Default Type" /></th>
					
						<th><g:message code="sessionGroup.defaultPlayground.label" default="Default Playground" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sessionGroupInstanceList}" status="i" var="sessionGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sessionGroupInstance.id}">${fieldValue(bean: sessionGroupInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: sessionGroupInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${sessionGroupInstance.competition}" /></td>
					
						<td><g:formatBoolean boolean="${sessionGroupInstance.visible}" /></td>
					
						<td>${fieldValue(bean: sessionGroupInstance, field: "defaultType")}</td>
					
						<td>${fieldValue(bean: sessionGroupInstance, field: "defaultPlayground")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sessionGroupInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
