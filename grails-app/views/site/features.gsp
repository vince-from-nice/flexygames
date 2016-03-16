<html>
    <head>
		<g:render template="/layouts/layout" />
    </head>
    <body>
        <h1><g:message code="features.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h2><g:message code="features.title.current" /></h2>
		<g:message code="features.currentFeaturesList" />
		<h2><g:message code="features.title.future" /></h2>
		<g:message code="features.futureFeaturesList" />
	</body>
</html>