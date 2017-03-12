
<%@ page import="flexygames.CarpoolProposal" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'carpoolProposal.label', default: 'CarpoolProposal')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-carpoolProposal" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-carpoolProposal" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="carpoolProposal.driver.label" default="Driver" /></th>
					
						<g:sortableColumn property="carDescription" title="${message(code: 'carpoolProposal.carDescription.label', default: 'Car Description')}" />
					
						<g:sortableColumn property="freePlaceNbr" title="${message(code: 'carpoolProposal.freePlaceNbr.label', default: 'Free Place Nbr')}" />
					
						<g:sortableColumn property="rdvDescription" title="${message(code: 'carpoolProposal.rdvDescription.label', default: 'Rdv Description')}" />
					
						<th><g:message code="carpoolProposal.session.label" default="Session" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${carpoolProposalInstanceList}" status="i" var="carpoolProposalInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${carpoolProposalInstance.id}">${fieldValue(bean: carpoolProposalInstance, field: "driver")}</g:link></td>
					
						<td>${fieldValue(bean: carpoolProposalInstance, field: "carDescription")}</td>
					
						<td>${fieldValue(bean: carpoolProposalInstance, field: "freePlaceNbr")}</td>
					
						<td>${fieldValue(bean: carpoolProposalInstance, field: "rdvDescription")}</td>
					
						<td>${fieldValue(bean: carpoolProposalInstance, field: "session")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${carpoolProposalInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
