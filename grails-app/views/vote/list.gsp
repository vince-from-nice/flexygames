
<%@ page import="flexygames.Vote" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'vote.label', default: 'Vote')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-vote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-vote" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="vote.player.label" default="Player" /></th>
					
						<g:sortableColumn property="score" title="${message(code: 'vote.score.label', default: 'Score')}" />
					
						<th><g:message code="vote.session.label" default="Session" /></th>
					
						<th><g:message code="vote.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${voteInstanceList}" status="i" var="voteInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${voteInstance.id}">${fieldValue(bean: voteInstance, field: "player")}</g:link></td>
					
						<td>${fieldValue(bean: voteInstance, field: "score")}</td>
					
						<td>${fieldValue(bean: voteInstance, field: "session")}</td>
					
						<td>${fieldValue(bean: voteInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${voteInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
