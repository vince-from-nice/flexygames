<html>
    <head>
        <meta name="layout" content="mobile" />
    </head>
    <body>

        <h1><g:message code="home.title" /></h1>

		<div style="border: solid 1px darkred; background-color: #ffcccc; padding: 10px; "><g:message code="home.mobileSite" /></div>

		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="errors">${flash.error}</div>
		</g:if>

		<h2 style=""><g:message code="home.whatisit.title" /></h2>
		<p><g:message code="home.whatisit.text1" /></p>
		<p><g:message code="home.whatisit.text2" /></p>
		<p><b><g:message code="home.whatisit.text3" /></b></p>
		<p><g:message code="home.whatisit.text4" /></p>

		<h2><g:message code="home.sessions.title.last"/></h2>
		<p><g:message code="home.session.closedXDays" args="[2, 6]"/> : </p>
		<table class="flexyTab">
			<tr>
				<th style="text-align: center;"><g:message code="teams" /></th>
				<th><g:message code="group" /></th>
				<th><g:message code="date" /></th>
				<th><g:message code="players" /></th>
				<th style="text-align: center;"><g:message code="myStatus" /></th>
				<th><g:message code="lastComment" /></th>
			</tr>
			<g:render template="/common/sessionMediumList" model="['sessionInstanceList': sessions]" />
		</table>

    </body>
</html>
