<!doctype html>
<html>
<head>
	<title>Unauthorized</title>
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card status-card">
		<p class="status-code">403</p>
		<h1>Not Authorized</h1>
		<p>
			You are not authorized
			<g:if test="${targetUri}">to access the page at <code>${targetUri?.encodeAsHTML()}</code>.</g:if>
			<g:else>to access this resource.</g:else>
		</p>
		<g:if test="${msg}">
			<p class="muted">The error message was: ${msg?.encodeAsHTML()}</p>
		</g:if>
		<shiro:isLoggedIn>
			<p class="muted">You are signed in as <strong><shiro:principal/></strong>.</p>
			<div class="form-actions">
				<g:link controller="site" action="home" class="btn btn-primary"><g:message code="layout.backToHome"/></g:link>
				<g:link controller="auth" action="signOut" class="btn btn-ghost"><g:message code="logbox.logout"/></g:link>
			</div>
		</shiro:isLoggedIn>
		<shiro:isNotLoggedIn>
			<p class="muted">You are not signed in.</p>
			<div class="form-actions">
				<g:link controller="auth" action="login" params="[targetUri: targetUri]" class="btn btn-primary"><g:message code="logbox.login"/></g:link>
				<g:link controller="site" action="home" class="btn btn-ghost"><g:message code="layout.backToHome"/></g:link>
			</div>
		</shiro:isNotLoggedIn>
	</div>
</body>
</html>
