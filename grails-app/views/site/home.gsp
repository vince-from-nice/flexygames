<html>
    <head>
        <meta name="layout" content="desktop" />
    </head>
    <body onload="if (detectBadBrowser()) alert('${message(code: "home.badBrowser")}');">
        <h1><g:message code="home.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="errors">${flash.error}</div>
		</g:if>
        <table style="border: 0px; width: 100%">
        	<tr>
        		<td style="min-width: 600px">
        			<h2 style=""><g:message code="home.whatisit.title" /></h2>
        			<p><g:message code="home.whatisit.text1" /></p>
        			<p><g:message code="home.whatisit.text2" /></p>
        			<p><b><g:message code="home.whatisit.text3" /></b></p>
        			<p><g:message code="home.whatisit.text4" /></p>
        			<!--p><g:message code="home.whatisit.video" /></p-->
        		</td>
        		<!--td style="width: 30%">
        			<h2><g:message code="home.news.title" /></h2>
        			<p><g:message code="home.news.text" /></p>
        		</td-->
        		<td style="min-width: 400px" rowspan="1">
        			<h2><g:message code="home.users.title" /></h2>
        			<table class="flexyTab">
						<g:each in="${users}" status="i" var="playerInstance">
							<g:set var="userLink" value="${createLink(controller: 'player', action: 'show', id: playerInstance.id, absolute: true)}" />
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="vertical-align: middle; cursor: pointer" onclick="document.location='${userLink}'">
								<td style="vertical-align: middle; height: 50px"> 
									<g:render template="/common/avatar" model="[player: playerInstance]" />
								</td>
								<td style="vertical-align: middle;"> 
									${fieldValue(bean: playerInstance, field: "username")}
								</td>
	                            <td style="vertical-align: middle; font-size: 12px">
	                                <g:each in="${playerInstance.allSubscribedTeams}" var="t">
	                                    <g:link controller="teams" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link><br />
	                                </g:each>
	                            </td>
	                            <td style="vertical-align: middle; font-size: 12px">
	                            	<flexy:humanDate date="${playerInstance.registrationDate.time}" />
	                            </td>
							</tr>
						</g:each>
        			</table>
        		</td>
        	</tr>
        	<tr>
        		<td colspan="2" rowspan="1">
        			<h2><g:message code="home.sessions.title.last"/></h2>
        			<p><g:message code="home.session.closedXDays" args="[2, 6]"/> : </p>
					<table class="flexyTab">
						<tr>
							<th style="padding-left: 0px;"><g:message code="teams" /></th>
							<th><g:message code="group" /></th>
							<th><g:message code="date" /></th>
							<th><g:message code="players" /></th>
							<th style="text-align: center;"><g:message code="myStatus" /></th>
							<th><g:message code="lastComment" /></th>
						</tr>
						<g:render template="/common/sessionMediumList" model="['sessionInstanceList': sessions]" />
					</table>
        		</td>
        	</tr>
        </table>
    </body>
</html>
