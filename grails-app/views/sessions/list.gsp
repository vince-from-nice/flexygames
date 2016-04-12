
<%@ page import="flexygames.SessionsController; flexygames.Session"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
</head>
<body>
	<h1>
		<g:message code="session.list" />
	</h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	<table style="width:  auto;">
	<tr>
		<td>
			<g:message code="session.list.chooseTeam" /> :
		</td>
		<td>
			<g:form name="teamFilterForm" action="list">
					<g:select name="filteredTeam" from="${flexygames.Team.list(sort: 'name')}" 
						optionKey="id" value="${session.filteredTeam}" noSelection="[0: message(code:'session.list.filter.allTeams')]"
						onChange="document.getElementById('teamFilterForm').submit();"  />
				</g:form>
		</td>
	</tr>
	<tr>
		<td>
			<g:message code="session.list.chooseSessionGroup" /> :
		</td>
		<td>
			<g:form name="groupFilterForm" action="list">
				<g:select name="filteredSessionGroup" from="${sessionGroups}"
					optionKey="id" value="${currentSessionGroup?.id}" noSelection="['0': message(code:'session.list.filter.allSessionGroups')]"
					onChange="document.getElementById('groupFilterForm').submit();"  />
			</g:form>
		</td>
	</tr>
	</table>
	<table class="flexyTab">
		<thead>
			<tr>
				<g:sortableColumn property="date" title="${message(code: 'date', default: 'Date')}" />
				<th><g:message code="teams" default="Teams" /></th>
				<th><g:message code="players" default="Players" /></th>
				<th><g:message code="myStatus" default="My Status" /></th>
				<th><g:message code="playground" default="Playground" /></th>
				<th><g:message code="rounds" default="Sets" /></th>
				<th><g:message code="votes" default="Votes" /></th>
				<th><g:message code="posts" default="Posts" /></th>
				<th style="vertical-align: middle; font-size: 12px"><g:message code="home.lastComment" /></th>
			</tr>
		</thead>
		<tbody>
			<g:render template="/common/sessionFullList" model="['sessionInstanceList': sessionInstanceList]" />
		</tbody>
	</table>
	<div class="pagination">
		<g:paginate total="${sessionListSize}" />
	</div>
</body>
</html>
