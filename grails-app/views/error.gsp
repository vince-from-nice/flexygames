<!doctype html>
<html>
<head>
	<title>Error</title>
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card status-card">
		<p class="status-code">${request.'jakarta.servlet.error.status_code' ?: 500}</p>
		<h1>Sorry, something went wrong</h1>
		<p class="muted">The error has been logged. Please try again, or go back to the homepage.</p>
		<div class="form-actions">
			<g:link controller="site" action="home" class="btn btn-primary"><g:message code="layout.backToHome"/></g:link>
		</div>
	</div>
	<%-- Exception details are for developers only: they reveal code and server paths. --%>
	<g:if env="development">
		<section class="card error-details">
			<h2>Error details</h2>
			<p>
				<strong>URI:</strong> ${request.'jakarta.servlet.error.request_uri'}<br/>
				<strong>Message:</strong> ${request.'jakarta.servlet.error.message'?.encodeAsHTML()}
			</p>
			<g:if test="${exception}">
				<p>
					<strong>Exception:</strong> ${exception.message?.encodeAsHTML()}<br/>
					<strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()}<br/>
					<strong>Class:</strong> ${exception.className}, line ${exception.lineNumber}
				</p>
				<pre class="error-snippet"><g:each var="cs" in="${exception.codeSnippet}">${cs?.encodeAsHTML()}
</g:each></pre>
				<h3>Stack trace</h3>
				<pre class="error-stack"><g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}
</g:each></pre>
			</g:if>
		</section>
	</g:if>
</body>
</html>
