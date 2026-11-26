<html>
<head>
	<g:render template="/common/layout" />
</head>
<body>
	<div class="page-header">
		<h1><g:message code="statistics.title" /></h1>
	</div>

	<h2><g:message code="statistics.global.title" /></h2>
	<div class="stat-tiles">
		<g:each in="${[
				['statistics.global.playerNbr', flexygames.User.count()],
				['statistics.global.teamNbr', flexygames.Team.count()],
				['statistics.global.sessionNbr', flexygames.Session.count()],
				['statistics.global.invitationNbr', flexygames.Participation.count()],
				['statistics.global.participationNbr', flexygames.Participation.getAllEffectiveCount()],
				['statistics.global.roundNbr', flexygames.SessionRound.count()],
				['statistics.global.actionNbr', flexygames.GameAction.count()],
				['statistics.global.voteNbr', flexygames.Vote.count()],
				['statistics.global.commentNbr', flexygames.SessionComment.count()],
				['statistics.global.compositionNbr', flexygames.Composition.count()],
				['statistics.global.carpoolRequestNbr', flexygames.CarpoolRequest.count()],
				['statistics.global.carpoolProposalNbr', flexygames.CarpoolProposal.count()]]}" var="counter">
			<div class="stat-tile">
				<strong>${counter[1]}</strong>
				<span><g:message code="${counter[0]}" /></span>
			</div>
		</g:each>
	</div>

	<div class="chart-grid">
		<section class="card">
			<h2><g:message code="statistics.teams.title" /></h2>
			<g:form name="teamsForm" controller="teams" action="show" method="get" class="stacked-form">
				<g:hiddenField name="mode" value="ranking"/>
				<label for="teamId"><g:message code="statistics.teams.select" /></label>
				<g:select id="teamId" name="id" from="${flexygames.Team.list(sort: 'name')}" optionKey="id" onChange="document.getElementById('teamsForm').submit();" noSelection="['':'']"/>
			</g:form>
		</section>
		<section class="card">
			<h2><g:message code="statistics.users.title" /></h2>
			<g:form name="usersForm" controller="player" action="stats" method="get" class="stacked-form">
				<label for="userId"><g:message code="statistics.users.select" /></label>
				<g:select id="userId" name="id" from="${flexygames.User.list(sort: 'username')}" optionKey="id" onChange="document.getElementById('usersForm').submit();" noSelection="['':'']"/>
			</g:form>
		</section>

		<g:render template="barChart" model="[title: message(code: 'statistics.global.participants'), items: participants]" />
		<g:render template="barChart" model="[title: message(code: 'statistics.global.posters'), items: posters]" />
		<g:render template="barChart" model="[title: message(code: 'statistics.global.teams'), items: teams]" />
		<g:render template="barChart" model="[title: message(code: 'statistics.global.sessions'), items: groups]" />
	</div>
</body>
</html>
