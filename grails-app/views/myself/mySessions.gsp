
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<h1><g:message code="mySessions.title" /></h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	<p class="muted"><g:message code="mySessions.infos" /></p>
	<div class="session-title">
		<g:if test="${request.week > 1}">
			<g:link action="mySessions" params="[year: request.year, week: request.week - 1]" class="btn btn-ghost">&larr; <g:message code="previousWeeks" /></g:link>
		</g:if>
		<g:else>
			<g:link action="mySessions" params="[year: request.year - 1, week: 52]" class="btn btn-ghost">&larr; <g:message code="previousWeeks" /></g:link>
		</g:else>
		<h2><g:message code="mySession.currentWeek" args="[request.week]" /> (${request.year})</h2>
		<g:if test="${request.week < 52}">
			<g:link action="mySessions" params="[year: request.year, week: request.week + 1]" class="btn btn-ghost"><g:message code="nextWeeks" /> &rarr;</g:link>
		</g:if>
		<g:else>
			<g:link action="mySessions" params="[year: request.year + 1, week: 1]" class="btn btn-ghost"><g:message code="nextWeeks" /> &rarr;</g:link>
		</g:else>
	</div>
	<div class="table-wrap">
	<table class="flexyTab">
		<thead>
			<tr>
				<g:sortableColumn property="date" title="${message(code: 'date', default: 'Date')}" />
				<th><g:message code="teams" default="Teams" /></th>
				<th><g:message code="groups" default="Groups" /></th>
				<th><g:message code="players" default="Players" /></th>
				<th class="status-head"><g:message code="myStatus" default="My Status" /></th>
				<g:if test="${request.display == 'desktop'}">
					<th class="col-optional"><g:message code="playground" default="Playground" /></th>
					<th class="col-optional"><g:message code="home.lastComment" /></th>
				</g:if>
			</tr>
		</thead>
		<tbody>
			<g:each in="${allSessions}" var="sessions" status="i">
				<tr class="day-row">
					<td colspan="10"><g:message code="mySession.currentWeek" args="[i + request.week]" /></td>
				</tr>
				<g:if test="${sessions.size() > 0}">
					<g:render template="/common/sessionLargeList" model="['sessionInstanceList': sessions]" />
				</g:if>
				<g:else>
					<tr>
						<td colspan="10" class="muted"><g:message code="mySessions.noSessions"/></td>
					</tr> 
				</g:else>
			</g:each>
		</tbody>
	</table>
	</div>
</body>
</html>
