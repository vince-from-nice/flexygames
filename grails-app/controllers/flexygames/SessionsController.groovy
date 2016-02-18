package flexygames

import org.apache.shiro.SecurityUtils

class SessionsController {
	
	def sessionService
	
	def votingService

	def forumService
		
	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list = {
		// prepare default params values
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "date"
		if(!params.order) params.order = "desc"

		// If the user changes back to "all" we need to reset the other filters too !
		if (params.filteredGameType == 'ALL' || params.filteredTeam == 'ALL') {
			params.filteredGameType = 'ALL'
			params.filteredTeam = 'ALL'
			params.filteredSessionGroup = 'ALL'
		}
		
		// update session with params
		if (params.filteredGameType) { session.filteredGameType = params.filteredGameType }
		if (params.filteredTeam) { session.filteredTeam = params.filteredTeam }
		if (params.filteredSessionGroup) { session.filteredSessionGroup = params.filteredSessionGroup }

		// construct fetching query (ugly, need to use "where" queries instead)
		def query = "from Session as session  where 1 = 1"
		def queryParams = []
		if (session.filteredGameType && session.filteredGameType != 'ALL') {
			query += " and session.type.id = ? "
			queryParams += Long.parseLong(session.filteredGameType)
		}
		if (session.filteredTeam && session.filteredTeam != 'ALL') {
			query += " and (1 = 2 "
			Team.get(session.filteredTeam).sessionGroups.each {
				query += " or session.group.id = ? "
				queryParams += it.id
			}
			query += ") "
		}
		if (session.filteredSessionGroup && session.filteredSessionGroup != 'ALL') {
			query += " and session.group.id = ? "
			queryParams += Long.parseLong(session.filteredSessionGroup)
		}
		query += " order by session.$params.sort $params.order"

		// perform query and render
		def sessionList = Session.findAll(query, queryParams, [max: params.max, offset: params.offset])
		def sessionListSize = Session.findAll(query, queryParams).size()
		[sessionInstanceList: sessionList, sessionListSize: sessionListSize]
	}

	def show = {
		Session session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			redirect(action: "list")
		}

		def allPlayers = session.participations*.player

		// Prepare data about participants
		// Since Participation.compareTo() is smart there is nothing special to do, the participation table will well sorted

		// Prepare data about memberships of participants (for feesUpToDate)
		Team defaultTeam = session.group.defaultTeams.first()
		// Fetch membership of all users of the session in one shot
		def allMembershipsForCurrentSession = Membership.findAllByTeamAndUserInList(defaultTeam, allPlayers)
//		session.participations.each { part ->
//			def player = part.player
//			def membership = allMembershipsForCurrentSession.find{it.user == player}
//			player.membershipInCurrentSession = membership
//			//println("- participant: " + player.username + " has fees up to date:" + membership?.feesUpToDate)
//		}
		allMembershipsForCurrentSession.each { membership ->
			def player = allPlayers.find{it == membership.user}
			player.membershipInCurrentSession = membership
		}

		// Prepare data about teams of participants
		def allMembershipsForAnySession = Membership.findAllByUserInList(allPlayers)
		// The previous request has fetched memberships of all players in one shot, now dispatch associated teams into their relative players
		allMembershipsForAnySession.each { membership ->
			def player = allPlayers.find{it == membership.user}
			player.teamsInCurrentSession << membership.team
		}

		// Prepare data about votes of participants (move it to the Vote domain class) ?
		def participantsByScore = []
		def effectivePlayers = session.getEffectiveParticipants()
		// Fetch all relevant votes in one query
		def allVotes = Vote.findAllBySessionAndPlayerInList(session, effectivePlayers)
		effectivePlayers.each{ player ->
			int score = 0
			//def votes = Vote.findAllBySessionAndPlayer(session, player)
			def votes = allVotes.grep{it.player == player}
			votes.each{vote -> score += vote.score}
			player.scoreInCurrentSession = score
			participantsByScore << player
			participantsByScore.sort{it.scoreInCurrentSession}
		}
		def currentVotes = null
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (user) {
			currentVotes = [:]
			def votes = Vote.findAllBySessionAndUser(session, user)
			votes.each{ vote ->
				if (vote.score == 3) currentVotes.put('firstPositive',  vote.player)
				else if (vote.score == 2) currentVotes.put('secondPositive',  vote.player)
				else if (vote.score == 1) currentVotes.put('thirdPositive',  vote.player)
				else if (vote.score == -3) currentVotes.put('firstNegative',  vote.player)
				else if (vote.score == -2) currentVotes.put('secondNegative',  vote.player)
				else if (vote.score == -1) currentVotes.put('thirdNegative',  vote.player)
			}
		}

		[sessionInstance: session, participantsByScore: participantsByScore.reverse(), currentVotes: currentVotes ]
	}

	// TODO remake the grails file uploader plugin
	def showAvatar = {
	def file = new File(params.path)
		if (file.exists()) {
			log.debug "Serving file path=${params.path} to ${request.remoteAddr}"
			response.setContentType("application/octet-stream")
			response.setHeader("Content-disposition", "${params.contentDisposition}; filename=${file.name}")
			response.outputStream << file.readBytes()
			return
		} else {
			def msg = messageSource.getMessage("fileupload.download.filenotfound", [params.path] as Object[], request.locale)
			log.error msg
			flash.message = msg
			redirect controller: params.errorController, action: params.errorAction
			return
		}
	}

	def update = {
		User user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to update status !!"
			return redirect(action: "list")
		}
		Participation participation = Participation.get(params.id)
		if (!participation) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Participation'), params.id])}"
			return redirect(action: "list")
		}
		try {
			sessionService.updatePlayerStatus(user, participation, params.statusCode, params.userLog)
			def newStatus = message(code: 'participation.status.' + params.statusCode)
			flash.message = "${message(code: 'session.show.update.success', args: [newStatus])}"
		} catch (Exception e) {
			println "Exception on status update: " + e.getMessage()
			flash.error = "${message(code: 'session.show.update.error', args: [e.message])}"
			return redirect(action: "show", id:participation.session.id)
		}

		// If user comes from another FG pages (such as the homepage or mySessions) we redirect to it
		String referer =  request.getHeader('referer')
		// FIXME
		if (referer.contains(grailsApplication.config.grails.serverURL)) {
			// Maybe adding a salt parameter would solve the issue with Chrome under Android ?
			return redirect(url:referer + "?salt=" + UUID.randomUUID().toString())
		}
		// Else we redirect to the session page
		return redirect(action: "show", id:participation.session.id)
	}

	def join = {
		User user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to update status !!"
			return redirect(action: "show", id: params.id)
		}
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		try  {
			sessionService.join(user, session)
			flash.message = "${message(code: 'session.show.participants.join.success')}"
		} catch (Exception e) {
			flash.error = e.message
			println flash.error
		}
		redirect(action: "show", id: params.id)
	}

	// Used by the mails sent by reminders (here the id is for the session, not for the participation like it is in the original method)
	def updateFromMail = {
		User user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to update status !!"
			return redirect(action: "list")
		}
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			redirect(action: "list")
		}
		Participation participation = Participation.findBySessionAndPlayer(session, user)
		if (!participation) {
			flash.error = "Sorry, unable to find your participation in the session !!"
			return redirect(action: "list")
		}
		try {
			sessionService.updatePlayerStatus(user, participation, params.statusCode, '')
			def newStatus = message(code: 'participation.status.' + params.statusCode)
			flash.message = "${message(code: 'session.show.update.success', args: [newStatus])}"
		} catch (Exception e) {
			flash.error = "${message(code: 'session.show.update.error', args: [e.message])}"
			return redirect(action: "show", id:participation.session.id)
		}
		return redirect(action: "show", id:participation.session.id)
	}

	def vote = {
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to vote !!"
			redirect(action: "show", id: session.id)
		}
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}

		def player = User.findByUsername(params.player)
		if (!player) {
			// TODO gérer ce cas afin de pouvoir annuler un vote
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'player', default: 'Player'), params.firstPositive])}"
			return redirect(action: "show", id: session.id)
		}
		
		try  {
			votingService.vote(user, player, session, params.voteType,)
			flash.message = "Your vote has been taken into account."
		} catch (Exception e) {
			flash.error = "${message(code: 'session.show.votes.update.error', args: [e.message])}"
			return redirect(uri: "/sessions/show/" + session.id)
		}

		redirect(uri: "/sessions/show/" + session.id + "#votingArea")
	}

	def post = {
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to post a comment !!"
			redirect(action: "show", id: session.id)
		}
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		def comment
		try {
			comment = forumService.postComment(user, session, params.comment)
			flash.message = "Ok comment has been posted !!"
		} catch (Exception e) {
			e.printStackTrace()
			flash.error = "${message(code: 'session.show.comments.update.error', args: [e.message])}"
			return redirect(uri: "/sessions/show/" + session.id)
		}
		redirect(uri: "/sessions/show/" + session.id + "#comment" + comment.id)
	}
	
	def watch = {
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal().toString())
		if (!user) {
			flash.error = "You need to be authenticated in order to post a comment !!"
			redirect(action: "show", id: session.id)
		}
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		try {
			def wantToWatch = params.watch != null
			forumService.watchSessionComments(user, session, wantToWatch)
			if (wantToWatch) {
				flash.message = "Ok you're watching that session now..."
			} else {
				flash.message = "Ok you're not watching that session anymore..."
			}
		} catch (Exception e) {
			flash.error = e.message
		}
		redirect(uri: "/sessions/show/" + session.id)
	}

}
