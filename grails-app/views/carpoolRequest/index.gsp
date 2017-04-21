
<%@ page import="flexygames.CarpoolRequest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'carpoolRequest.label', default: 'CarpoolRequest')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-carpoolRequest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-carpoolRequest" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="carpoolRequest.enquirer.label" default="Enquirer" /></th>
					
						<th><g:message code="carpoolRequest.driver.label" default="Driver" /></th>
					
						<g:sortableColumn property="pickupLocation" title="${message(code: 'carpoolRequest.pickupLocation.label', default: 'Pickup Location')}" />
					
						<g:sortableColumn property="pickupTimeRange" title="${message(code: 'carpoolRequest.pickupTimeRange.label', default: 'Pickup Time Range')}" />
					
						<g:sortableColumn property="pickupTime" title="${message(code: 'carpoolRequest.pickupTime.label', default: 'Pickup Time')}" />
					
						<th><g:message code="carpoolRequest.session.label" default="Session" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${carpoolRequestInstanceList}" status="i" var="carpoolRequestInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${carpoolRequestInstance.id}">${fieldValue(bean: carpoolRequestInstance, field: "enquirer")}</g:link></td>
					
						<td>${fieldValue(bean: carpoolRequestInstance, field: "driver")}</td>
					
						<td>${fieldValue(bean: carpoolRequestInstance, field: "pickupLocation")}</td>
					
						<td>${fieldValue(bean: carpoolRequestInstance, field: "pickupTimeRange")}</td>
					
						<td>${fieldValue(bean: carpoolRequestInstance, field: "pickupTime")}</td>
					
						<td>${fieldValue(bean: carpoolRequestInstance, field: "session")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${carpoolRequestInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
