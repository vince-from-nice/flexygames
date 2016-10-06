
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
	<p><g:message code="mySessions.infos" /></p>
	<br />
	<table>
		<tr>
			<td style="text-align: left;">
				<g:if test="${request.week > 1}">
					<g:link action="mySessions" params="[year: request.year, week: request.week - 1]"><< <g:message code="previousWeeks" /></g:link>
				</g:if>
				<g:else>
					<g:link action="mySessions" params="[year: request.year - 1, week: 52]"><< <g:message code="previousWeeks" /></g:link>
				</g:else>
			</td>				
			<td style="text-align: center;">
				<span style="font-size: 18px; font-weight: bold;"><g:message code="mySession.currentWeek" args="[request.week]" /> (${request.year})</span>
			</td>
			<td style="text-align: right;">
				<g:if test="${request.week < 52}">
					<g:link action="mySessions" params="[year: request.year, week: request.week + 1]"><g:message code="nextWeeks" /> >></g:link>
				</g:if>
				<g:else>
					<g:link action="mySessions" params="[year: request.year + 1, week: 1]"><g:message code="nextWeeks" /> >></g:link>
				</g:else>
			</td>
		</tr>
	</table>
	<table class="flexyTab">
		<thead>
			<tr>
				<g:sortableColumn property="date" title="${message(code: 'date', default: 'Date')}" />
				<th style="text-align: left; padding-left: 0px"><g:message code="teams" default="Teams" /></th>
				<th style="text-align: left"><g:message code="groups" default="Groups" /></th>
				<th style="text-align: left"><g:message code="players" default="Players" /></th>
				<th style="text-align: center"><g:message code="myStatus" default="My Status" /></th>
				<g:if test="${request.display == 'desktop'}">
					<th style="text-align: left"><g:message code="playground" default="Playground" /></th>
					<th style="text-align: left; vertical-align: middle; font-size: 12px"><g:message code="home.lastComment" /></th>
				</g:if>
			</tr>
		</thead>
		<tbody>
			<g:each in="${allSessions}" var="sessions" status="i">
				<tr>
					<td colspan="10" style="text-align: center;"><b><g:message code="mySession.currentWeek" args="[i + request.week]" /></b></td>
				</tr>
				<g:if test="${sessions.size() > 0}">
					<g:render template="/common/sessionLargeList" model="['sessionInstanceList': sessions]" />
				</g:if>
				<g:else>
					<tr>
						<td colspan="10" style="text-align: center;"><i><g:message code="mySessions.noSessions"/></i></td>
					</tr> 
				</g:else>
			</g:each>
		</tbody>
	</table>
</body>
</html>
