
<%@ page import="flexygames.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
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
		<h2><g:message code="myAccount.myPersonalInfos" /></h2>
		<table style="width: 100%;">
			<tr>
				<td rowspan="1">
					<table style="border: 0px">
						<tbody>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="username" default="Username" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "username")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="firstName" default="First Name" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "firstName")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="lastName" default="Last Name" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "lastName")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="email" default="Email" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "email")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="phoneNumber" default="Phone Number" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "phoneNumber")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="company" default="Company" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "company")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="city" default="City" /></td>
								<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "city")}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="birthYear" default="Birth Year" /></td>
								<td valign="top" class="value">${playerInstance?.yearBirthDate}</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name"><g:message code="registrationDate" default="Registration Date" /></td>
								<td valign="top" class="value"><g:formatDate date="${playerInstance?.registrationDate}" format="yyyy-MM-dd" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				</td>
				<td style="text-align: center;">
					<g:render template="/common/avatar" model="[player:playerInstance, width:'auto']" />
					<br />
					<span style="font-size: 12px">
						<g:message code="myAccount.uploadAvatar" /><br />
						<fileuploader:form	upload="avatar" id="${playerInstance.id}"
							successAction="changeAvatarSuccess" successController="myself"
							errorAction="changeAvatarError" errorController="myself" />
					</span>
				</td>
			</tr>
			<g:form>
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
						<div class="buttons">
							<input type="button" class="edit" onclick="toggleDisplay('changePasswordDiv')" value="${message(code:'myAccount.changeMyPassword')}" >
						</div>
						<div id="changePasswordDiv" style="display: none">
							<g:message code="myAccount.oldPassword" /> <g:passwordField style="width: 100px" name="oldPassword"/><br />
							<g:message code="myAccount.newPassword" /> <g:passwordField style="width: 100px" name="newPassword"/><br />
							<g:actionSubmit class="edit" action="changeMyPassord" value="${message(code:'change')}" />
						</div>
					</td>
				</tr>
			</g:form>
			<tr>
				<td>
					<h2><g:message code="myAccount.myTeams" /></h2>
					<table>
						<tr>
							<th><g:message code="name" /></th>
							<th><g:message code="training" />?</th>
							<th><g:message code="competition" />?</th>
							<th></th>
							<th></th>
						</tr>
						<g:if test="${playerInstance.allMemberships.size() > 0}">
							<g:each in="${playerInstance.allMemberships}" var="m">
								<g:form>
									<g:hiddenField name="id" value="${m.id}" />
									<tr>
										<td><g:link controller="teams" action="show" id="${m.team.id}">${m.team}</g:link></td>
										<td>
											<g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForTraining ? message(code:'regular') : message(code:'tourist')}" /> 
										</td>
										<td>
											<g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" value="${m.regularForCompetition ? message(code:'regular') : message(code:'tourist')}" />
										</td>
										<td>
											<span class="button"><g:actionSubmit class="edit" action="updateMembership" value="${message(code:'update')}" /> </span>
										</td>
										<td>
											<span class="button"><g:actionSubmit class="remove" action="leaveTeam" value="${message(code:'leave')}" /> </span>
										</td>
									</tr>
								</g:form>
							</g:each>
						</g:if>
						<g:else>
							<tr>
								<td colspan="5"><i><g:message code="myAccount.noTeams" /></i></td>
							</tr>
						</g:else>
						<tr>
							<th colspan="5" style="text-align: center"><g:message code="myAccount.joinNewTeam" /></th>
						</tr>
						<g:form>
							<tr>
								<td><g:select name="id" from="${flexygames.Team.list(sort:'name', order:'asc')}" optionKey="id" /></td>
								<td><g:select name="regularForTraining" from="[message(code:'regular'), message(code:'tourist')]" /> </td>
								<td><g:select name="regularForCompetition" from="[message(code:'regular'), message(code:'tourist')]" /></td>
								<td colspan="2"><span class="button"><g:actionSubmit class="create" action="joinTeam" value="${message(code:'join')}" /> </span></td>
							</tr>
						</g:form>	
					</table>
					<h3><g:message code="myAccount.membershipExplanation.title" /></h3>
					<p><g:message code="myAccount.membershipExplanation.text" /></p>
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
							<span class="button"><g:actionSubmit class="create" action="addSkill" value="${message(code:'myAccount.addNewSkill')}" /> </span>
							<g:select name="id" from="${flexygames.GameSkill.list(sort:'type', order:'asc')}" optionKey="id" />
						</g:form>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
