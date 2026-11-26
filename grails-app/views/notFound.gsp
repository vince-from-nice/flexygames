<!doctype html>
<html>
<head>
	<title>Page Not Found</title>
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card status-card">
		<p class="status-code">404</p>
		<h1>Page Not Found</h1>
		<p class="muted">${request.forwardURI?.encodeAsHTML()}</p>
		<div class="form-actions">
			<g:link controller="site" action="home" class="btn btn-primary"><g:message code="layout.backToHome"/></g:link>
		</div>
	</div>
</body>
</html>
