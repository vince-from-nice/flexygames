
<%@ page import="flexygames.Participation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'participation.label', default: 'Participation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-participation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-participation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="participation.player.label" default="Player" /></th>
					
						<th><g:message code="participation.session.label" default="Session" /></th>
					
						<g:sortableColumn property="statusCode" title="${message(code: 'participation.statusCode.label', default: 'Status Code')}" />
					
						<g:sortableColumn property="userLog" title="${message(code: 'participation.userLog.label', default: 'User Log')}" />
					
						<g:sortableColumn property="lastUpdate" title="${message(code: 'participation.lastUpdate.label', default: 'Last Update')}" />
					
						<g:sortableColumn property="lastUpdater" title="${message(code: 'participation.lastUpdater.label', default: 'Last Updater')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${participationInstanceList}" status="i" var="participationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${participationInstance.id}">${fieldValue(bean: participationInstance, field: "player")}</g:link></td>
					
						<td>${fieldValue(bean: participationInstance, field: "session")}</td>
					
						<td>${fieldValue(bean: participationInstance, field: "statusCode")}</td>
					
						<td>${fieldValue(bean: participationInstance, field: "userLog")}</td>
					
						<td><g:formatDate date="${participationInstance.lastUpdate}" /></td>
					
						<td>${fieldValue(bean: participationInstance, field: "lastUpdater")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${participationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
