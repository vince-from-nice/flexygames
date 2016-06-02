
<%@ page import="flexygames.TaskType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'taskType.label', default: 'TaskType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-taskType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-taskType" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'taskType.code.label', default: 'Code')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${taskTypeInstanceList}" status="i" var="taskTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${taskTypeInstance.id}">${fieldValue(bean: taskTypeInstance, field: "code")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${taskTypeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
