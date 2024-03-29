package flexygames

import grails.gorm.transactions.Transactional

import java.time.ZoneId

class SessionsController {

	def displayService

	def sessionsService

	def votingService

	def forumService
	
	def oldForecastService

	///////////////////////////////////////////////////////////////////////////////////////////////
	// Following actions are not transactional and not restricted to authenticated users
	///////////////////////////////////////////////////////////////////////////////////////////////

	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list() {
		// prepare default params values
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "date"
		if(!params.order) params.order = "desc"

		// Update session with params
		def currentSessionGroup
		if (params.filteredTeam) {
			session.filteredTeam = Integer.parseInt(params.filteredTeam)
			// If the user changes filtered team we need to reset the session group to "any"
			session.filteredSessionGroup = 0
		} else if (params.filteredSessionGroup) {
			session.filteredSessionGroup = Integer.parseInt(params.filteredSessionGroup)
			// If the user changes filtered session group we need to reset the team too
			if (session.filteredSessionGroup > 0) {
				currentSessionGroup = SessionGroup.get(session.filteredSessionGroup)
				session.filteredTeam = currentSessionGroup.getDefaultTeams().first().getId()
			}
		}

		// Prepare data for the view
		def sessionList
		def sessionListSize = 0
		def sessionGroups
		//SessionGroupForSelectTag currentSessionGroupForSelectTag = new SessionGroupForSelectTag()
		if (session.filteredSessionGroup > 0) {
			if (currentSessionGroup == null) currentSessionGroup = SessionGroup.get(session.filteredSessionGroup)
			//currentSessionGroupForSelectTag = new SessionGroupForSelectTag(currentSessionGroup.id, currentSessionGroup.toString())
			sessionGroups = currentSessionGroup.defaultTeams.first().sessionGroups
			sessionList = Session.findAllByGroup(currentSessionGroup, [max: params.max, offset: params.offset])
			sessionListSize = Session.countByGroup(currentSessionGroup)
		} else if (session.filteredTeam > 0) {
			sessionGroups = Team.get(session.filteredTeam).sessionGroups
			if (sessionGroups.size() > 0) {
				sessionList = Session.findAllByGroupInList(sessionGroups, [max: params.max, offset: params.offset])
				sessionListSize = Session.countByGroupInList(sessionGroups)
			}
		} else {
			sessionGroups = SessionGroup.list()
			sessionList = Session.list([max: params.max, offset: params.offset])
			sessionListSize = Session.count()
		}
		[sessionInstanceList: sessionList, sessionListSize: sessionListSize,
		 sessionGroups: sessionGroups, currentSessionGroup: currentSessionGroup,
		]
	}

	def show() {
		def currentUser = request.currentUser
		Session session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			redirect(action: "list")
		}

		// Prepare data about participants
		def allPlayers = session.participations*.player
		if (allPlayers.size() > 0) {
			// Since Participation.compareTo() is smart there is nothing special to do about sorting

			// Prepare data about memberships of participants (for feesUpToDate)
			Team defaultTeam = session.group.defaultTeams.first()
			// Fetch membership of all users of the session in one shot
			def allMembershipsForCurrentSession = Membership.findAllByTeamAndUserInList(defaultTeam, allPlayers)

			allMembershipsForCurrentSession.each { membership ->
				def player = allPlayers.find { it == membership.user }
				player.membershipInCurrentSession = membership
			}

			// Prepare data about teams of participants
			def allMembershipsForAnySession = Membership.findAllByUserInList(allPlayers)
			// The previous request has fetched memberships of all players in one shot, now dispatch associated teams into their relative players
			allMembershipsForAnySession.each { membership ->
				def player = allPlayers.find { it == membership.user }
				player.teamsInCurrentSession << membership.team
			}
		}

		// Prepare data about carpooling
		def approvedCarpoolRequestIds = '['
		def relatedCarpoolProposalIds = '['
		def relatedSeatIndexes = '['
		def relatedPickupTimes = '['
		def seatIndex = 1
		session.carpoolRequests.each { request ->
			if (request.driver) {
				approvedCarpoolRequestIds += request.id + ', '
				relatedCarpoolProposalIds += request.driver.id + ', '
				relatedSeatIndexes += seatIndex++ + ', '
				relatedPickupTimes += '\'' + request.pickupTime + '\', '
			}
		}
		if (approvedCarpoolRequestIds.endsWith(', ')) {
			approvedCarpoolRequestIds = approvedCarpoolRequestIds.substring(0, approvedCarpoolRequestIds.length() - 2)
			relatedCarpoolProposalIds = relatedCarpoolProposalIds.substring(0, relatedCarpoolProposalIds.length() - 2)
			relatedSeatIndexes = relatedSeatIndexes.substring(0, relatedSeatIndexes.length() - 2)
			relatedPickupTimes = relatedPickupTimes.substring(0, relatedPickupTimes.length() - 2)
		}
		approvedCarpoolRequestIds += ']'
		relatedCarpoolProposalIds += ']'
		relatedSeatIndexes += ']'
		relatedPickupTimes += ']'

		// Prepare data about votes of participants (move it to the Vote domain class) ?
		def currentVotes = null
		def participantsByScore = []
		def effectivePlayers = session.getEffectiveParticipants()
		if (effectivePlayers.size() > 0) {
			// Fetch all relevant votes in one query
			def allVotes = Vote.findAllBySessionAndPlayerInList(session, effectivePlayers)
			effectivePlayers.each { player ->
				int score = 0
				//def votes = Vote.findAllBySessionAndPlayer(session, player)
				def votes = allVotes.grep { it.player == player }
				votes.each { vote -> score += vote.score }
				player.scoreInCurrentSession = score
				participantsByScore << player
				participantsByScore.sort { it.scoreInCurrentSession }
			}
			if (currentUser) {
				currentVotes = [:]
				def votes = allVotes.grep { it.user == currentUser }
				votes.each { vote ->
					if (vote.score == 3) currentVotes.put('firstPositive', vote.player)
					else if (vote.score == 2) currentVotes.put('secondPositive', vote.player)
					else if (vote.score == 1) currentVotes.put('thirdPositive', vote.player)
					else if (vote.score == -3) currentVotes.put('firstNegative', vote.player)
					else if (vote.score == -2) currentVotes.put('secondNegative', vote.player)
					else if (vote.score == -1) currentVotes.put('thirdNegative', vote.player)
				}
			}
		}

		// Prepare data about tasks
		def tasksByTypeCode = [:]
		session.tasks.each {
			if (tasksByTypeCode[it.type.code]) tasksByTypeCode[it.type.code] += it
			else tasksByTypeCode[it.type.code] = [it]
		}

		// Enhance texts of comments
		session.comments.each { comment ->
			forumService.enhanceText(comment)
		}

		// Get the day of week (as int) for the Windy widget
		//def dayOfTheWeek = java.text.SimpleDateFormat('E').format(session.date)

		render(view: (displayService.isMobileDevice(request) ? 'mobileShow' : 'show'),
				model: [sessionInstance          : session, participantsByScore: participantsByScore.reverse(), currentVotes: currentVotes,
						approvedCarpoolRequestIds: approvedCarpoolRequestIds, relatedCarpoolProposalIds: relatedCarpoolProposalIds,
						relatedSeatIndexes       : relatedSeatIndexes, relatedPickupTimes: relatedPickupTimes, tasksByTypeCode: tasksByTypeCode])
	}

	// TODO remake the grails file uploader plugin
	/*def showAvatar = {
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
	}*/

	///////////////////////////////////////////////////////////////////////////////////////////////
	// Following actions are transactional (explicitly or via the use of a service)
	// and restricted to authenticated users (via Shiro interceptor)
	///////////////////////////////////////////////////////////////////////////////////////////////

	def update() {
		Participation participation = Participation.get(params.id)
		if (!participation) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Participation'), params.id])}"
			return redirect(action: "list")
		}
		try {
			sessionsService.updatePlayerStatus(request.currentUser, participation, params.statusCode, params.userLog)
			def newStatus = message(code: 'participation.status.' + params.statusCode)
			flash.message = "${message(code: 'session.show.update.success', args: [newStatus])}"
		} catch (Exception e) {
			println "Exception on status update: " + e.getMessage()
			flash.error = "${message(code: 'session.show.update.error', args: [e.message])}"
			return redirect(action: "show", id:participation.session.id)
		}

		// If user comes from another FG pages (such as the homepage or mySessions) we redirect to it
		String referer =  request.getHeader('referer')
		if (referer.contains(grailsApplication.config.grails.serverURL)) {
			// Maybe adding a salt parameter solve the issue with Chrome under Android
			return redirect(url:referer + (referer.contains('?') ? '&' : '?') + "salt=" + UUID.randomUUID().toString())
		}
		// Else we redirect to the session page
		return redirect(action: "show", id:participation.session.id)
	}

	def join(){
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		try  {
			sessionsService.join(request.currentUser, session)
			flash.message = "${message(code: 'session.show.participants.join.success')}"
		} catch (Exception e) {
			flash.error = e.message
			println flash.error
		}
		redirect(action: "show", id: params.id)
	}

	// Used by the mails sent by reminders (here the id is for the session, not for the participation like it is in the original method)
	def updateFromMail() {
		User user = request.currentUser
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		Participation participation = Participation.findBySessionAndPlayer(session, user)
		if (!participation) {
			flash.error = "Sorry, unable to find your participation in the session !!"
			return redirect(action: "list")
		}
		try {
			sessionsService.updatePlayerStatus(user, participation, params.statusCode, '')
			def newStatus = message(code: 'participation.status.' + params.statusCode)
			flash.message = "${message(code: 'session.show.update.success', args: [newStatus])}"
		} catch (Exception e) {
			flash.error = "${message(code: 'session.show.update.error', args: [e.message])}"
			return redirect(action: "show", id:participation.session.id)
		}
		return redirect(action: "show", id: participation.session.id)
	}

	def vote() {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		try  {
			votingService.vote(session, request.currentUser, params)
			flash.votingMessage = "Your vote has been taken into account."
		} catch (Exception e) {
			flash.votingError = "${message(code: 'session.show.votes.update.error', args: [e.message])}"
			return redirect(action: "show", id: session.id, fragment: "votingArea")
		}
		redirect(action: "show", id:session.id, fragment: "votingArea")
	}

	def post () {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		def comment
		try {
			comment = forumService.postSessionComment(request.currentUser, session, params.comment)
			flash.message = "Ok comment has been posted !!"
		} catch (Exception e) {
			e.printStackTrace()
			flash.error = "${message(code: 'session.show.comments.update.error', args: [e.message])}"
			return redirect(action: "show", id: session.id)
		}
		redirect(action: "show", id:session.id, fragment: "comment" + comment.id)
	}

	def watch() {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		try {
			def wantToWatch = params.watch != null
			forumService.watchSessionComments(request.currentUser, session, wantToWatch)
			if (wantToWatch) {
				flash.message = "Ok you're watching that session now..."
			} else {
				flash.message = "Ok you're not watching that session anymore..."
			}
		} catch (Exception e) {
			flash.error = e.message
		}
		redirect(action: "show", id: session.id)
	}

	@Transactional
	def addCarpoolProposal() {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		CarpoolProposal proposal = new CarpoolProposal(session: session, driver: request.currentUser, freePlaceNbr: params.freePlaceNbr,
				carDescription: params.carDescription, rdvDescription: params.rdvDescription)
		if (!proposal.save()) {
			flash.error = "Unable to save your carpool proposal: " + proposal.errors
		} else {
			flash.message = "Ok your carpool proposal has been saved"
		}
		redirect(action: "show", id: session.id)
	}

	@Transactional
	def addCarpoolRequest() {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		CarpoolRequest request = new CarpoolRequest(session: session, enquirer: request.currentUser, pickupLocation: params.pickupLocation, pickupTimeRange: params.pickupTimeRange)
		if (!request.save()) {
			flash.error = "Unable to save your carpool request: " + request.errors
		} else {
			flash.message = "Ok your carpool request has been saved"
		}
		redirect(action: "show", id: session.id)
	}

	@Transactional
	def removeCarpoolProposal() {
		def proposal = CarpoolProposal.get(params.id)
		if (proposal.driver != request.currentUser && !proposal.session.isManagedBy(request.currentUser.username)) {
			flash.error = "You cannot remove this carpool proposal because you are not the driver (neither a manager of the team)"
			return redirect(action: "show", id: proposal.session.id)
		}
		proposal.approvedRequests.toArray().each{proposal.removeFromApprovedRequests(it)}
        proposal.save()
		proposal.delete()
		flash.message = "Ok carpool proposal has been removed !"
		redirect(action: "show", id: proposal.session.id)
	}

	@Transactional
    def cancelAllCarpoolAcceptances() {
        def proposal = CarpoolProposal.get(params.id)
        if (proposal.driver != request.currentUser && !proposal.session.isManagedBy(request.currentUser.username)) {
            flash.error = "You cannot reset this carpool proposal because you are not the driver (neither a manager of the team)"
            return redirect(action: "show", id: proposal.session.id)
        }
		proposal.approvedRequests.each{it.pickupTime = ''}
		proposal.approvedRequests.toArray().each{proposal.removeFromApprovedRequests(it)}
        proposal.save()
        flash.message = "Ok carpool proposal has been reset !"
        redirect(action: "show", id: proposal.session.id)
    }

	@Transactional
	def removeCarpoolRequest() {
		def cpr = CarpoolRequest.get(params.id)
		if (cpr.enquirer != request.currentUser && !request.session.isManagedBy(request.currentUser.username)) {
			flash.error = "You cannot remove this carpool request because you are not the enquirer (neither a manager of the team)"
			return redirect(action: "show", id: cpr.session.id)
		}
		cpr.delete()
		flash.message = "Ok carpool request has been removed !"
		redirect(action: "show", id: cpr.session.id)
	}

	@Transactional
	def updateCarpoolProposal() {
		CarpoolProposal proposal = CarpoolProposal.get(params.id)
		if (proposal.driver != request.currentUser && !proposal.session.isManagedBy(request.currentUser.username)) {
			flash.error = "You cannot update this carpool proposal because you are not the driver (neither a manager of the team)"
			return redirect(action: "show", id: proposal.session.id)
		}
		proposal.approvedRequests.clear()
		def approvedRequestIds = params.approvedRequestIds.split(',')
		def seatIndexes = params.seatIndexes.split(',')
		for (int i = 0; i < approvedRequestIds.length; i++) {
			CarpoolRequest request = CarpoolRequest.get(approvedRequestIds[i])
			if (request) {
				request.pickupTime = params['pickupTimeForProposal' + params.id + "Seat" + (seatIndexes[i])]
				proposal.addToApprovedRequests(request)
			}
		}
		if (proposal.save()) {
			flash.message = "Ok carpool proposal has been updated!"
		} else {
			flash.error = "Unable to update carpool proposal: " + proposal.errors
		}
		redirect(action: "show", id: proposal.session.id)
	}

	@Transactional
	def addTask() {
		def session = Session.get(params.id)
		if (!session) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'session', default: 'Session'), params.id])}"
			return redirect(action: "list")
		}
		if (session.date < new Date()) {
			flash.error = "${message(code: 'tooLateForThatAction')}"
			return redirect(action: "show", id: session.id)
		}
		TaskType taskType = TaskType.findByCode(params.newTaskCode)
		if (!taskType) {
			flash.error = "Unable to find task type " + params.newTaskCode
			return redirect(action: "show", id: session.id)
		}
		Task task = Task.findByTypeAndSessionAndUser(taskType, session, request.currentUser)
		if (task) {
			flash.error = "${message(code: 'session.show.tasks.alreadyAssigned')}"
			return redirect(action: "show", id: session.id)
		}
		task = new Task(type: taskType, session: session, user: request.currentUser)
		if (task.save()) {
			flash.message = "Ok your task has been saved !"
		} else {
			flash.error = "Unable to save task: " + task.errors
		}
		redirect(action: "show", id: task.session.id)
	}

	@Transactional
	def deleteTask() {
		def task = Task.get(params.id)
		if (!task) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'task', default: 'Task'), params.id])}"
			return redirect(action: "list")
		}
		if (task.user != request.currentUser && !task.session.isManagedBy(request.currentUser.username)) {
			flash.error = "${message(code: 'youAreNotAuthorized')}"
			return redirect(action: "list")
		}
		task.delete()
		flash.message = "Ok task has been removed !"
		redirect(action: "show", id: task.session.id)
	}
}
