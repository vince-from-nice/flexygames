<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
</head>
<body>
    <h1>FlexyGames Administration Page</h1>
    <br />
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		<br />
	</g:if>
    <g:form controller="admin">
    	<p>Refresh counters for all players : <g:actionSubmit value="Refresh" action="refreshPlayerCounters" /> </p>
    </g:form>
</body>
</html>
