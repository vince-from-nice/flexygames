package flexygames

import java.text.SimpleDateFormat

import org.apache.shiro.SecurityUtils
import org.jsoup.Jsoup
import org.jsoup.safety.Whitelist;

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
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			redirect(action: "list")
		}
		else {
			// Prepare data about compositions (move it to the Composition domain class) ?
//			def playersByComposition = []
//			session.compositions.each { compo ->
//				def compositionPlayers = [:]
//				compositionPlayers['compositionId'] = compo.id
//				def players = []
//				compo.items.each { item ->
//					def player = [id: item.player.id, x: item.x, y: item.y]
//					players << player
//				}
//				playersByComposition << compositionPlayers
//			}
			
			// Prepare data about votes (move it to the Vote domain class) ?
			def participantsByScore = []
			session.getEffectiveParticipants().each{ player ->
				int score = 0
				def votes = Vote.findAllBySessionAndPlayer(session, player)
				votes.each { vote ->
					score += vote.score
				}
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
			
			[sessionInstance: session, /*playersByComposition: playersByComposition,*/ 
				participantsByScore: participantsByScore.reverse(), currentVotes: currentVotes ]
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Participation'), params.id])}"
			return redirect(action: "list")
		}
		try {
			sessionService.updatePlayerStatus(user, participation, params.statusCode, params.userLog)
			def newStatus = message(code: 'participation.status.' + params.statusCode)
			flash.message = "${message(code: 'session.show.update.success', args: [newStatus])}"
		} catch (Exception e) {
			flash.error = "${message(code: 'session.show.update.error', args: [e.message])}"
			return redirect(action: "show", id:participation.session.id)
		}

		// If user comes from another FG pages (such as the homepage or mySessions) we redirect to it
		String referer =  request.getHeader('referer')
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}

		def player = User.findByUsername(params.player)
		if (!player) {
			// TODO gérer ce cas afin de pouvoir annuler un vote
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.firstPositive])}"
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
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
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])}"
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
