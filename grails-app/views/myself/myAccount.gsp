<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
	<title><g:message code="myAccount.title" /></title>
</head>
<body>
	<div class="page-header">
		<h1><g:message code="myAccount.title" /></h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors">${flash.error}</div>
	</g:if>

	<div class="account-grid">
		<div class="account-main">
			<section class="card">
				<div class="section-title">
					<h2><g:message code="myAccount.myPersonalInfos" /></h2>
				</div>
				<g:render template="profile" />
				<div class="buttons">
					<g:link action="editMyProfile" id="${playerInstance?.id}" class="btn btn-primary">${message(code: 'myAccount.editPersonalInfos')}</g:link>
					<g:link controller="player" action="show" id="${playerInstance?.id}" class="btn">${message(code: 'myAccount.viewMyProfile')}</g:link>
				</div>
			</section>

			<section class="card">
				<h2><g:message code="myAccount.myTeams" /></h2>
				<g:render template="memberships" />
			</section>
		</div>

		<aside class="account-aside">
			<section class="card avatar-card">
				<g:render template="/common/avatar" model="[player: playerInstance, width: '160px']" />
				<g:form controller="fileUpload" action="process" method="post" enctype="multipart/form-data" class="upload-form">
					<g:hiddenField name="uploadType" value="userAvatar" />
					<g:hiddenField name="id" value="${playerInstance.id}" />
					<g:hiddenField name="errorAction" value="changeAvatarError" />
					<g:hiddenField name="errorController" value="myself" />
					<g:hiddenField name="successAction" value="changeAvatarSuccess" />
					<g:hiddenField name="successController" value="myself" />
					<label for="avatarFile" class="muted small"><g:message code="myAccount.uploadAvatar" /></label>
					<input type="file" id="avatarFile" name="file" accept="image/jpeg,image/png,image/gif" />
					<input type="submit" name="submit" value="${message(code: 'default.button.upload.label', default: 'Upload')}" />
				</g:form>
			</section>

			<section class="card">
				<h2><g:message code="myAccount.changeMyPassword" /></h2>
				<g:form class="stacked-form">
					<label for="oldPassword"><g:message code="myAccount.oldPassword" /></label>
					<g:passwordField name="oldPassword" id="oldPassword" autocomplete="current-password" />
					<label for="newPassword"><g:message code="myAccount.newPassword" /></label>
					<g:passwordField name="newPassword" id="newPassword" autocomplete="new-password" />
					<g:actionSubmit action="changeMyPassord" value="${message(code: 'change')}" />
				</g:form>
			</section>

			<section class="card">
				<h2><g:message code="myAccount.mySkills" /></h2>
				<g:if test="${playerInstance.skills}">
					<ul class="skill-list">
						<g:each in="${playerInstance.skills}" var="s">
							<li>
								<span><strong>${s.code}</strong> <span class="muted">${s.type.name}</span></span>
								<g:link action="removeSkill" id="${s.id}" class="small"><g:message code="myAccount.removeSkill" /></g:link>
							</li>
						</g:each>
					</ul>
				</g:if>
				<g:form class="inline-row">
					<g:select name="id" from="${flexygames.GameSkill.list(sort: 'type', order: 'asc')}" optionKey="id" />
					<g:actionSubmit action="addSkill" value="${message(code: 'myAccount.addNewSkill')}" />
				</g:form>
			</section>
		</aside>
	</div>
</body>
</html>
