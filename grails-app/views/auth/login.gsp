<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <g:render template="/common/layout" />
  <title>Login</title>
</head>
<body>
<div class="card auth-card">
  <h1><g:message code="logbox.login" /></h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:form action="signIn">
    <input type="hidden" name="targetUri" value="${targetUri}" />
    <div class="field">
      <label for="username"><g:message code="logbox.login" /></label>
      <input type="text" id="username" name="username" value="${username}" autocomplete="username" required />
    </div>
    <div class="field">
      <label for="password"><g:message code="logbox.password" /></label>
      <input type="password" id="password" name="password" value="" autocomplete="current-password" required />
    </div>
    <label><g:checkBox name="rememberMe" value="${rememberMe}" /> <g:message code="logbox.rememberMe" /></label>
    <input type="submit" value="${message(code: 'logbox.login')}" />
    <div class="links">
      <g:link controller="player" action="remindPassword"><g:message code="logbox.remindPassword" /></g:link>
      <g:link controller="player" action="register"><g:message code="logbox.newAccount" /></g:link>
    </div>
  </g:form>
</div>
</body>
</html>
