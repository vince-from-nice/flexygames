<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
	<div class="body">
		<h1>
			<g:message code="player.list.title" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<br />
		<p>
			<g:message code="player.list.findPlayer" /> : &nbsp;&nbsp;&nbsp;
			<g:link action="list" params="[first: '']"><g:message code="All" /></g:link>&nbsp;&nbsp;&nbsp;
			<g:each in="${ ('A'..'Z')}" var="first" >
			<g:link action="list" params="[first: first]">${first}</g:link>&nbsp;&nbsp;&nbsp;
			</g:each>
		</p>
		<br />
		<div class="flexyTab">
			<table>
				<thead>
					<tr>
						<th></th>
						<g:sortableColumn property="username" title="${message(code: 'username', default: 'Username')}" />
						<g:sortableColumn property="firstName" title="${message(code: 'firstName', default: 'First Name')}" />
						<g:sortableColumn property="lastName" title="${message(code: 'lastName', default: 'Last Name')}" />
						<g:sortableColumn property="company" title="${message(code: 'company', default: 'Company')}" />
						<g:sortableColumn property="city" title="${message(code: 'city', default: 'City')}" />
						<th><g:message code="teams" /></th>
						<g:sortableColumn style="font-size: 10px; vertical-align: middle" property="participationCounter" title="${message(code: 'participations', default: 'Participations')}" />
						<g:sortableColumn style="font-size: 10px; vertical-align: middle" property="commentCounter" title="${message(code: 'comments', default: 'Comments')}" />
						<g:sortableColumn style="font-size: 10px; vertical-align: middle" property="voteCounter" title="${message(code: 'votes', default: 'Votes')}" />
						<!--g:sortableColumn style="font-size: 10px; vertical-align: middle" property="skills" title="${message(code: 'skills', default: 'Skills')}" /-->
						<g:sortableColumn style="font-size: 10px; vertical-align: middle" property="registrationDate" title="${message(code: 'registration', default: 'Registration Date')}" />
						<g:sortableColumn style="font-size: 10px; vertical-align: middle" property="lastLogin" title="${message(code: 'lastLogin', default: 'Last login')}" />

					</tr>
				</thead>
				<tbody>
					<g:each in="${playerInstanceList}" status="i" var="playerInstance">
						<g:set var="playerLink" value="${createLink(controller: 'player', action: 'show', id: playerInstance.id, absolute: true)}" />
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="height: 50px; cursor: pointer" onclick="document.location='${playerLink}'">
							<td style="vertical-align: middle; text-align: right; margin: 0px; padding: 0px;"> 
								<g:render template="/common/avatar" model="[player:playerInstance]" />
							</td>
							<td style="vertical-align: middle; text-align: left; ">
								<nobr>${fieldValue(bean: playerInstance, field: "username")}</nobr>
							</td>
							<td style="vertical-align: middle; font-size: 12px;"><nobr>${fieldValue(bean: playerInstance, field: "firstName")}</nobr></td>
							<td style="vertical-align: middle; font-size: 12px;"><nobr>${fieldValue(bean: playerInstance, field: "lastName")}</nobr></td>
							<td style="vertical-align: middle; font-size: 12px;"><nobr>${fieldValue(bean: playerInstance, field: "company")}</nobr></td>
							<td style="vertical-align: middle; font-size: 12px;"><nobr>${fieldValue(bean: playerInstance, field: "city")}</nobr></td>
                            <td style="vertical-align: middle; font-size: 10px; line-height: 10px">
                                <g:each in="${playerInstance.allSubscribedTeams}" var="t">
                                    <nobr><g:link controller="teams" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link><br /></nobr>
                                </g:each>
                            </td>
                            <!--td style="vertical-align: middle;">
                                <g:each in="${playerInstance.skills}" var="s">
                                    <g:link controller="skill" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link><br />
                                </g:each>
                            </td-->
							<td style="vertical-align: middle;">
								${playerInstance.participationCounter}
							</td>
							<td style="vertical-align: middle;">
								${playerInstance.commentCounter}
							</td>
							<td style="vertical-align: middle;">
								${playerInstance.voteCounter}
							</td>
                            <td style="vertical-align: middle; font-size: 12px;">
								<nobr><g:formatDate date="${playerInstance.registrationDate}" format="yyyy-MM-dd" timeStyle="LONG" /></nobr>
                            </td>
                            <td style="vertical-align: middle; font-size: 12px;">
								<nobr><g:formatDate date="${playerInstance.lastLogin}" format="yyyy-MM-dd" timeStyle="LONG" /></nobr>
                            </td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="pagination">
			<g:paginate total="${playerInstanceTotal}" params="${['first':params.first]}" />
		</div>
	</div>
</body>
</html>
