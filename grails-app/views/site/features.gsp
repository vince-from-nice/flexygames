<html>
<head>
	<g:render template="/common/layout" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="features.title" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<section class="card prose">
		<h2><g:message code="features.title.current" /></h2>
		<g:message code="features.currentFeaturesList" />
	</section>
	<section class="card prose">
		<h2><g:message code="features.title.future" /></h2>
		<g:message code="features.futureFeaturesList" />
	</section>
</body>
</html>
