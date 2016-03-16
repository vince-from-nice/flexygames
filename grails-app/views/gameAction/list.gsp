
<%@ page import="flexygames.GameAction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'gameAction.label', default: 'GameAction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-gameAction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-gameAction" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="gameAction.sessionRound.label" default="Session Round" /></th>
					
						<th><g:message code="gameAction.mainContributor.label" default="Main Contributor" /></th>
					
						<th><g:message code="gameAction.secondaryContributor.label" default="Secondary Contributor" /></th>
					
						<g:sortableColumn property="forFirstTeamIfOrphelin" title="${message(code: 'gameAction.forFirstTeamIfOrphelin.label', default: 'For First Team If Orphelin')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${gameActionInstanceList}" status="i" var="gameActionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${gameActionInstance.id}">${fieldValue(bean: gameActionInstance, field: "sessionRound")}</g:link></td>
					
						<td>${fieldValue(bean: gameActionInstance, field: "mainContributor")}</td>
					
						<td>${fieldValue(bean: gameActionInstance, field: "secondaryContributor")}</td>
					
						<td><g:formatBoolean boolean="${gameActionInstance.forFirstTeamIfOrphelin}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${gameActionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
