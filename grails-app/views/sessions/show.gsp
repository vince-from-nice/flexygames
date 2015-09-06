<%@ page import="flexygames.Session"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	<g:javascript library="interact-1.2.4.min" />
</head>
<body>
	<table style="width: 100%">
		<tr>
			<td style="text-align: left;">
				<g:if test="${sessionInstance.previousSessionInGroup}">
				   <g:link action="show" id="${sessionInstance.previousSessionInGroup.id}">&lt;&lt; <g:message code="session.show.previous" /></g:link>
				</g:if>
				<g:else>
				   &lt;&lt; <g:message code="session.show.previous" />
				</g:else>
			</td>				
			<td style="text-align: center;">
				<g:if test="${sessionInstance.name}">
					<h1>${fieldValue(bean: sessionInstance, field: "name")}</h1>
				</g:if>
				<g:else>
					<h1 style="margin: 0px">
						<g:message code="session.show.title" />
						<g:formatDate date='${sessionInstance?.date}' format="EEEEEEE dd MMMM" />
					</h1>
				</g:else>
			</td>
			<td style="text-align: right;">
			    <g:if test="${sessionInstance.nextSessionInGroup}">
			       <g:link action="show" id="${sessionInstance.nextSessionInGroup.id}"><g:message code="session.show.next" /> &gt;&gt;</g:link>
			    </g:if>
			    <g:else>
			       <g:message code="session.show.next" /> &gt;&gt;
			    </g:else>
			</td>
		</tr>
	</table>
    
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>
	
	<g:render template="/sessions/infos" />

	<g:render template="/sessions/participants" />
	
	<g:render template="/sessions/compositions" />

	<g:render template="/sessions/scoresheet" />

    <g:render template="/sessions/votes" />

	<g:render template="/sessions/comments" />
	
	<g:render template="/layouts/backLinks" />
				
</body>
</html>
