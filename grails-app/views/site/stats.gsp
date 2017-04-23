<%@ page import="flexygames.SessionComment" %>
<html>
    <head>
		<g:render template="/common/layout" />
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'flexycharts-20160303.js')}"></script>
		<!--g:javascript library="flexycharts" /-->
    </head>
    <body onload="
    	drawGColumnChart('${message(code:'statistics.global.participants')}', 'participantsDiv', ${participants}, 1000, 300, 'participations');
    	drawGColumnChart('${message(code:'statistics.global.posters')}', 'postersDiv', ${posters}, 1000, 300, 'posts');
    	drawGPieChart('${message(code:'statistics.global.teams')}', 'teamsDiv', ${teams}, 450, 300);
    	drawGPieChart('${message(code:'statistics.global.sessions')}', 'sessionGroupsDiv', ${groups}, 450, 300);">
        <h1><g:message code="statistics.title" /></h1>
        <table style="width: auto;">
        	<tr>
        		<td>
        			<h2><g:message code="statistics.global.title" /></h2>
			        <ul>
			        	<li><g:message code="statistics.global.playerNbr" /> : <b>${flexygames.User.count()}</b></li>
			        	<li><g:message code="statistics.global.teamNbr" /> : <b>${flexygames.Team.count()}</b></li>
			        	<li><g:message code="statistics.global.sessionNbr" /> : <b>${flexygames.Session.count()}</b></li>
						<!--<li><g:message code="statistics.global.effectiveSessionNbr" /> : <b>${/*flexygames.Session.getAllEffectiveCount()*/'?'}</b></li>-->
			        	<li><g:message code="statistics.global.invitationNbr" /> : <b>${flexygames.Participation.count()}</b></li>
			        	<li><g:message code="statistics.global.participationNbr" /> : <b>${flexygames.Participation.getAllEffectiveCount()}</b></li>
			        	<li><g:message code="statistics.global.roundNbr" /> : <b>${flexygames.SessionRound.count()}</b></li>
			        	<li><g:message code="statistics.global.actionNbr" /> : <b>${flexygames.GameAction.count()}</b></li>
			        	<li><g:message code="statistics.global.voteNbr" /> : <b>${flexygames.Vote.count()}</b></li>
			        	<li><g:message code="statistics.global.commentNbr" /> : <b>${flexygames.SessionComment.count()}</b></li>
			        	<li><g:message code="statistics.global.compositionNbr" /> : <b>${flexygames.Composition.count()}</b></li>
						<li><g:message code="statistics.global.carpoolRequestNbr" /> : <b>${flexygames.CarpoolRequest.count()}</b></li>
						<li><g:message code="statistics.global.carpoolProposalNbr" /> : <b>${flexygames.CarpoolProposal.count()}</b></li>
			        </ul>
        		</td>
        		<td>
			        <h2><g:message code="statistics.teams.title" /></h2>
					<g:message code="statistics.teams.select" />
					<g:form name="teamsForm" controller="teams" action="show">
						<g:hiddenField name="mode" value="ranking"/>
						<g:select name="id" from="${flexygames.Team.list(sort: 'name')}" optionKey="id" onChange="document.getElementById('teamsForm').submit();" noSelection="['':'']"/>
					</g:form>
			        <h2><g:message code="statistics.users.title" /></h2>
					<g:message code="statistics.users.select" />
					<g:form name="usersForm" controller="player" action="stats">
						<g:select name="id" from="${flexygames.User.list(sort: 'username')}" optionKey="id" onChange="document.getElementById('usersForm').submit();"  noSelection="['':'']"/>
					</g:form>
        		</td>
        	</tr>
        	<tr>
        		<td colspan="2"><div id="participantsDiv"></div></td>
        	</tr>
        	<tr>
        		<td colspan="2"><div id="postersDiv"></div></td>
        	</tr>
        	<tr>
        		<td><div id="teamsDiv"></div></td>
        		<td><div id="sessionGroupsDiv"></div></td>
        	</tr>
        </table>
	</body>
</html>
