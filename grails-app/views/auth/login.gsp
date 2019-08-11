<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <g:render template="/common/layout" />
  <title>Login</title>
</head>
<body>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:form action="signIn">
  <input type="hidden" name="targetUri" value="${targetUri}" />
  <table>
    <tbody>
    <tr>
      <td><g:message code="logbox.login" /></td>
      <td><input type="text" name="username" value="${username}" /></td>
    </tr>
    <tr>
      <td><g:message code="logbox.password" /></td>
      <td><input type="password" name="password" value="" /></td>
    </tr>
    <tr>
      <td><g:message code="logbox.rememberMe" /></td>
      <td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
    </tr>
    <tr>
      <td />
      <td><input type="submit" value="Login" /></td>
    </tr>
    </tbody>
  </table>
</g:form>
</body>
</html>