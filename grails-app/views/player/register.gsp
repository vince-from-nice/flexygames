<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
</head>
<body>
	<div class="card form-card">
		<h1><g:message code="register.title" default="Register" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${user}">
			<div class="errors">
				<g:renderErrors bean="${user}" as="list" />
			</div>
		</g:hasErrors>
		<g:form method="post">
			<g:hiddenField name="id" value="${user?.id}" />
			<g:hiddenField name="version" value="${user?.version}" />
			<div class="field ${hasErrors(bean: user, field: 'username', 'error')}">
				<label for="username"><g:message code="username" default="Username" /> <span class="required-mark">*</span></label>
				<g:textField name="username" value="${user?.username}" autocomplete="username" required="" />
				<p class="field-help"><g:message code="register.username.desc"/></p>
			</div>
			<div class="field">
				<label for="password"><g:message code="password" default="Password" /> <span class="required-mark">*</span></label>
				<g:passwordField name="password" value="" autocomplete="new-password" required="" />
				<g:passwordField name="passwordBis" value="" autocomplete="new-password" required="" aria-label="${message(code: 'password')} (2)" />
				<p class="field-help"><g:message code="register.password.desc"/></p>
			</div>
			<div class="field ${hasErrors(bean: user, field: 'email', 'error')}">
				<label for="email"><g:message code="player.email.label" default="Email" /> <span class="required-mark">*</span></label>
				<g:textField name="email" value="${user?.email}" autocomplete="email" required="" />
				<g:textField name="emailBis" value="${user?.email}" autocomplete="email" required="" aria-label="${message(code: 'player.email.label', default: 'Email')} (2)" />
				<p class="field-help"><g:message code="register.email.desc"/></p>
			</div>
			<div class="field ${hasErrors(bean: user, field: 'firstName', 'error')}">
				<label for="firstname"><g:message code="firstName" default="Firstname" /></label>
				<g:textField name="firstname" value="${user?.firstName}" autocomplete="given-name" />
				<p class="field-help"><g:message code="register.firstname.desc"/></p>
			</div>
			<div class="field">
				<label for="teamId"><g:message code="team"/></label>
				<g:select name="teamId" from="${flexygames.Team.list(sort:'name', order:'asc')}" noSelection="['':'']" optionKey="id" />
				<p class="field-help"><g:message code="register.team.desc"/></p>
			</div>
			<script type="text/javascript">
				function checkForm() {
					if (document.getElementById('email').value != document.getElementById('emailBis').value) {
						alert("Please enter the same email address twice !");
						return false;
					}
					if (document.getElementById('password').value != document.getElementById('passwordBis').value) {
						alert("Please enter the same password twice !");
						return false;
					}
				}
			</script>
			<g:actionSubmit onclick="return checkForm()" class="create" action="save" value="${message(code:'register')}" />
		</g:form>
	</div>
</body>
</html>
