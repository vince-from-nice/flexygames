<%@ page import="flexygames.Team" %>
<g:set var="teamIsManagedByCurrentUser" value="${teamInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
</head>
<body>
	<h1>${teamInstance}</h1>
	<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
	</g:if>
	<table style="width: 100%; border: 0px">
		<tr>
			<td>
				<h2><g:message code="informations" /></h2>
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><g:message code="city" default="City" /></td>
							<td valign="top" class="value">
								${fieldValue(bean: teamInstance, field: "city")}
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><g:message code="webUrl" default="Web Url" /></td>
							<td valign="top" class="value">
								<g:link url="${teamInstance.webUrl}">
									${fieldValue(bean: teamInstance, field: "webUrl")}
								</g:link>
							</td>
						</tr>
						<!--tr class="prop">
							<td valign="top" class="name"><g:message code="email" default="Email" /></td>
							<td valign="top" class="value">
								<a href="mailto:${teamInstance.email}">${fieldValue(bean: teamInstance, field: "email")}</a>
							</td>
						</tr-->
						<tr class="prop">
							<td valign="top" class="name"><g:message code="managers" default="Manager(s)" /></td>
							<td>
								<g:each in="${teamInstance.managers}" var="m">
									<g:link controller="player" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link>
								</g:each>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
			<td>
				<h2><g:message code="statistics" /></h2>
				<div class="block" style="width: auto">
					<g:message code="team.stats.totalOfMembers" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${teamInstance.members.size()}
					</span>
					<br />
					<g:message code="team.stats.totalOfSessions" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${teamInstance.countSessions()}
					</span>
					<br />
					<g:message code="team.stats.totalOfEffectiveSessions" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${teamInstance.allEffectiveSessions.size()}
					</span>
					<br />
					<g:message code="team.stats.totalOfParticipations" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${teamInstance.allParticipationCount}
					</span>
					<br />
					<g:message code="team.stats.totalOfEffectiveParticipations" /> :
					<span style="font-size: 20px; font-weight: bold;">
						${teamInstance.allEffectiveParticipationCount}
					</span>
				</div>
			</td>
			<td style="text-align: center;">
				<img style="max-width: 200px; max-height:120px;" src="${resource(dir:'images/team',file:teamInstance.logoName)}" alt="Team logo" />
				<g:if test="${teamIsManagedByCurrentUser}">
					<br />
					<br />
					<span style="font-size: 12px">
					<g:message code="team.show.uploadLogo" /><br />
					<g:form controller="fileUpload" action="process" method="post" enctype="multipart/form-data" >
						<g:hiddenField name="uploadType" value="teamLogo" />
						<g:hiddenField name="id" value="${teamInstance.id}" />
						<g:hiddenField name="errorAction" value="changeTeamLogoError" />
						<g:hiddenField name="errorController" value="manager" />
						<g:hiddenField name="successAction" value="changeTeamLogoSuccess" />
						<g:hiddenField name="successController" value="manager" />
						<input type='file' name='file' />
						<input type='submit' name='submit' value='Submit' />
					</g:form>
				</g:if>
			</td>
		</tr>
	</table>
	
	<table style="width: 100%; ">

		<g:if test="${params.mode=='blog' }">
			<g:set var="classForblogTab" value="tabSelected" />
			<g:set var="classForCompetitionTab" value="tabNotSelected" />
			<g:set var="classForTrainingTab" value="tabNotSelected" />
			<g:set var="classForMembersTab" value="tabNotSelected" />
			<g:set var="classForRankingTab" value="tabNotSelected" />
		</g:if>
		<g:if test="${params.mode=='competition' }">
			<g:set var="classForblogTab" value="tabNotSelected" />
			<g:set var="classForCompetitionTab" value="tabSelected" />
			<g:set var="classForTrainingTab" value="tabNotSelected" />	
			<g:set var="classForMembersTab" value="tabNotSelected" />
			<g:set var="classForRankingTab" value="tabNotSelected" />
		</g:if>
		<g:if test="${params.mode=='training' }">
			<g:set var="classForblogTab" value="tabNotSelected" />
			<g:set var="classForCompetitionTab" value="tabNotSelected" />
			<g:set var="classForTrainingTab" value="tabSelected" />	
			<g:set var="classForMembersTab" value="tabNotSelected" />
			<g:set var="classForRankingTab" value="tabNotSelected" />
		</g:if>
		<g:if test="${params.mode=='members' }">
			<g:set var="classForblogTab" value="tabNotSelected" />
			<g:set var="classForCompetitionTab" value="tabNotSelected" />
			<g:set var="classForTrainingTab" value="tabNotSelected" />	
			<g:set var="classForMembersTab" value="tabSelected" />
			<g:set var="classForRankingTab" value="tabNotSelected" />
		</g:if>
		<g:if test="${params.mode=='ranking' }">
			<g:set var="classForblogTab" value="tabNotSelected" />
			<g:set var="classForCompetitionTab" value="tabNotSelected" />
			<g:set var="classForTrainingTab" value="tabNotSelected" />	
			<g:set var="classForMembersTab" value="tabNotSelected" />
			<g:set var="classForRankingTab" value="tabSelected" />
		</g:if>

		<g:set var="blogLink" value="${createLink(action: 'show', params: [id: teamInstance.id, mode: 'blog'])}" />
		<g:set var="competitionLink" value="${createLink(action: 'show', params: [id: teamInstance.id, mode: 'competition'])}" />
		<g:set var="trainingLink" value="${createLink(action: 'show', params: [id: teamInstance.id, mode: 'training'])}" />
		<g:set var="membersLink" value="${createLink(action: 'show', params: [id: teamInstance.id, mode: 'members'])}" />
		<g:set var="rankingLink" value="${createLink(action: 'show', params: [id: teamInstance.id, mode: 'ranking'])}" />

		<tr style="">
			<td class="${classForblogTab}" style="width: 20%;  cursor: pointer;" onclick="document.location='${blogLink}'">
				<b><g:message code="blog"/></b>
			</td>
			<td class="${classForCompetitionTab}" style="width: 20%;  cursor: pointer;" onclick="document.location='${competitionLink}'">
				<b><g:message code="competitions"/></b>
			</td>
			<td class="${classForTrainingTab}" style="width: 20%;  cursor: pointer;" onclick="document.location='${trainingLink}'">
				<b><g:message code="trainings"/></b>
			</td>
			<td class="${classForMembersTab}" style="width: 20%;  cursor: pointer;" onclick="document.location='${membersLink}'">
				<b><g:message code="members"/></b>
			</td>
			<td class="${classForRankingTab}" style="width: 20%;  cursor: pointer;" onclick="document.location='${rankingLink}'">
				<b><g:message code="rankings"/></b>
			</td>
		</tr>
		
		<tr>
			<td colspan="4">
				<g:if test="${params.mode=='blog'}">
					<g:render template="showBlog" />
				</g:if>
				<g:if test="${params.mode=='competition' || params.mode=='training' }">
					<g:render template="showSessions" />
				</g:if>
				<g:if test="${params.mode=='members'}">
					<g:render template="showMembers" />
				</g:if>
				<g:if test="${params.mode=='ranking'}">
					<g:render template="showRanking" />
				</g:if>
			</td>
		</tr>
	</table>
		
	<g:render template="/layouts/backLinks" />
		
  </body>
</html>
