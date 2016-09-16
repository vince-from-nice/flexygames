
<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="body">
		<h1><g:message code="myAccount.title" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="errors">${flash.error}</div>
		</g:if>
		<table style="width: 100%;">
			<tr>
				<td colspan="1">
					<h2><g:message code="myAccount.myPersonalInfos" /></h2>
					<g:render template="profile" />
				</td>
				<td>
					<h2><g:message code="myAccount.mySkills" /></h2>
					<table>
						<g:each in="${playerInstance.skills}" var="s">
							<tr>
								<td>${s.type.name}</td>
								<td>${s.code}</td>
								<td><g:link action="removeSkill" id="${s.id}"><g:message code="myAccount.removeSkill" /></g:link></td>
							</tr>
						</g:each>
					</table>
					<div class="buttons">
						<g:form>
							<g:select name="id" from="${flexygames.GameSkill.list(sort:'type', order:'asc')}" optionKey="id" />
							<span class="button"><g:actionSubmit class="create" action="addSkill" value="${message(code:'myAccount.addNewSkill')}" /> </span>
						</g:form>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="nav">
						<ul>
							<li><g:link class="edit" action="editMyProfile" id="${playerInstance?.id}"><img src="../images/skin/database_edit.png"> ${message(code:'myAccount.editPersonalInfos')}</g:link></li>
							<li><g:link class="list" controller="player" action="show" id="${playerInstance?.id}">${message(code:'myAccount.viewMyProfile')}</g:link></li>
						</ul>
					</div>
				</td>
				<td>
					<g:form>
						<div class="buttons">
							<input type="button" class="edit" onclick="toggleDisplay('changePasswordDiv')" value="${message(code:'myAccount.changeMyPassword')}" >
						</div>
						<div id="changePasswordDiv" style="display: none">
							<g:message code="myAccount.oldPassword" /> <g:passwordField style="width: 100px" name="oldPassword"/><br />
							<g:message code="myAccount.newPassword" /> <g:passwordField style="width: 100px" name="newPassword"/><br />
							<g:actionSubmit class="edit" action="changeMyPassord" value="${message(code:'change')}" />
						</div>
					</g:form>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<g:render template="/common/avatar" model="[player:playerInstance, width:'auto']" />
					<br />
					<span style="font-size: 12px">
						<g:message code="myAccount.uploadAvatar" /><br />
						<g:form controller="fileUpload" action="process" method="post" enctype="multipart/form-data" >
							<g:hiddenField name="uploadType" value="userAvatar" />
							<g:hiddenField name="id" value="${playerInstance.id}" />
							<g:hiddenField name="errorAction" value="changeAvatarError" />
							<g:hiddenField name="errorController" value="myself" />
							<g:hiddenField name="successAction" value="changeAvatarSuccess" />
							<g:hiddenField name="successController" value="myself" />
							<input type='file' name='file' />
							<input type='submit' name='submit' value='Submit' />
						</g:form>
					</span>
				</td>

			</tr>
			<tr>
				<td colspan="2">
					<h2><g:message code="myAccount.myTeams" /></h2>
					<g:render template="memberships" />
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
