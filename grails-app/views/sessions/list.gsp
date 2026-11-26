<%@ page import="flexygames.SessionsController; flexygames.Session"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="session.list" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>

	<div class="filters card">
		<g:form name="teamFilterForm" action="list" class="filter">
			<label for="filteredTeam"><g:message code="session.list.chooseTeam" /></label>
			<g:select name="filteredTeam" from="${flexygames.Team.list(sort: 'name')}"
				optionKey="id" value="${session.filteredTeam}" noSelection="[0: message(code:'session.list.filter.allTeams')]"
				onChange="document.getElementById('teamFilterForm').submit();" />
		</g:form>
		<g:form name="groupFilterForm" action="list" class="filter">
			<label for="filteredSessionGroup"><g:message code="session.list.chooseSessionGroup" /></label>
			<g:select name="filteredSessionGroup" from="${sessionGroups}"
				optionKey="id" value="${currentSessionGroup?.id}" noSelection="['0': message(code:'session.list.filter.allSessionGroups')]"
				onChange="document.getElementById('groupFilterForm').submit();" />
		</g:form>
	</div>

	<div class="table-wrap">
	<table class="flexyTab session-table">
		<thead>
			<tr>
				<g:sortableColumn property="date" title="${message(code: 'date', default: 'Date')}" />
				<th><g:message code="teams" default="Teams" /></th>
				<th><g:message code="players" default="Players" /></th>
				<th class="status-head"><g:message code="myStatus" default="My Status" /></th>
				<g:if test="${request.display == 'desktop'}">
					<th class="col-optional"><g:message code="playground" default="Playground" /></th>
					<th class="col-optional number"><g:message code="rounds" default="Sets" /></th>
					<th class="col-optional number"><g:message code="votes" default="Votes" /></th>
					<th class="col-optional number"><g:message code="posts" default="Posts" /></th>
					<th class="col-optional"><g:message code="home.lastComment" /></th>
				</g:if>
			</tr>
		</thead>
		<tbody>
			<g:render template="/common/sessionFullList" model="['sessionInstanceList': sessionInstanceList]" />
		</tbody>
	</table>
	</div>
	<div class="pagination">
		<g:paginate total="${sessionListSize}" />
	</div>
</body>
</html>
