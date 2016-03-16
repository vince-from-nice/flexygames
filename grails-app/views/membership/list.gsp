
<%@ page import="flexygames.Membership" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'membership.label', default: 'Membership')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-membership" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-membership" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="membership.user.label" default="User" /></th>
					
						<th><g:message code="membership.team.label" default="Team" /></th>
					
						<g:sortableColumn property="manager" title="${message(code: 'membership.manager.label', default: 'Manager')}" />
					
						<g:sortableColumn property="regularForTraining" title="${message(code: 'membership.regularForTraining.label', default: 'Regular For Training')}" />
					
						<g:sortableColumn property="regularForCompetition" title="${message(code: 'membership.regularForCompetition.label', default: 'Regular For Competition')}" />
					
						<g:sortableColumn property="feesUpToDate" title="${message(code: 'membership.feesUpToDate.label', default: 'Fees Up To Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${membershipInstanceList}" status="i" var="membershipInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${membershipInstance.id}">${fieldValue(bean: membershipInstance, field: "user")}</g:link></td>
					
						<td>${fieldValue(bean: membershipInstance, field: "team")}</td>
					
						<td><g:formatBoolean boolean="${membershipInstance.manager}" /></td>
					
						<td><g:formatBoolean boolean="${membershipInstance.regularForTraining}" /></td>
					
						<td><g:formatBoolean boolean="${membershipInstance.regularForCompetition}" /></td>
					
						<td><g:formatBoolean boolean="${membershipInstance.feesUpToDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${membershipInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
