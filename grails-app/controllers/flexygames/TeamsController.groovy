package flexygames

class TeamsController {

	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list = {
		// prepare default params values
		params.max = Math.min(params.max ? params.int('max') : 10, 30)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "name"
		if(!params.order) params.order = "asc"
		def teams = Team.list(params)
		def teamsNbr = Team.count()
		[teamInstanceList: teams, teamInstanceTotal: teamsNbr]
	}

	def show = {
		def team = Team.get(params.id)
		if (!team) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team'), params.id])}"
			return redirect(action: "list")
		}
		if (!params.mode) {
			/*if (team.getAllSessionGroups(true).size() > 0) {
				params.mode = "competition"
			} else {
				params.mode = "training"
			}*/
			params.mode = "blog"
		}
		if (params.mode == "blog") {
			params.teamId = team.id
			params.max = Math.min(params.max ? params.int('max') : 10, 30)
			if(!params.offset) params.offset = 0
			if(!params.sort) params.sort = "date"
			if(!params.order) params.order = "desc"
			// Get blog entries for all users of the team
			def userBlogEntries = team.getBlogEntriesForAllMembers()
			// Create implicit blog entries from the sessions of the team
			def sessions = team.getSessions(params)
			def sessionBlogEntries = []
			sessions.each { session ->
				BlogEntry be = new BlogEntry()
				be.date = session.date
				be.team = session.group.defaultTeams[0]
				be.session = session
				if (session.name) {
					be.title = session.name + " (" + session.date + ")"
				} else {
					be.title = session.group.competition
				}

				sessionBlogEntries << be
			}
			// TODO merge the pagination between userBlogEntries and sessionBlogEntries
			def blogEntriesTotal = team.countSessions()
			def allBlogEntries = userBlogEntries + sessionBlogEntries
			return [teamInstance: team, allBlogEntries: allBlogEntries, blogEntriesTotal: blogEntriesTotal, params: params]
		}
		else if (params.mode == "ranking") {
			def criteria = (params.criteria ? params.criteria : 'statuses.doneGood')
			def sessionGroupId = (params.sessionGroupId ? Integer.parseInt(params.sessionGroupId) : 0)
			 return [teamInstance: team, members: getMembersTreeForRanking(params, team, criteria, sessionGroupId), currentCriteria: criteria, currentSessionGroupId: sessionGroupId]
		} else {
			[teamInstance: team]
		}
	}
	
	// TODO redo that ugly method
	def private getMembersTreeForRanking(params, Team team, String criteria, int sessionGroupId) {
		TreeMap<User, Number> memberMap = new TreeMap<User, Number> ()
		// TODO make it customizable
		def MIN_PARTS_FOR_AVERAGE_SCORING = 10
		def members = team.members
		SessionGroup sessionGroup
		if (sessionGroupId > 0) {
			sessionGroup = SessionGroup.get(sessionGroupId)
		}
		members.each { player ->
			def value = 0
			if (criteria.equals('successRatio')) {
				def wins, parts
				if (sessionGroup) {
					wins = player.getWinsBySessionGroup(sessionGroup).size()
					parts = wins + player.getDrawsBySessionGroup(sessionGroup).size() + player.getDefeatsBySessionGroup(sessionGroup).size()
				} else {
					wins = player.getWinsByTeam(team).size()
					parts = wins + player.getDrawsByTeam(team).size() + player.getDefeatsByTeam(team).size()
				}
				if (parts > 0) {
					value = wins / parts
				}
			} else if (criteria.equals('actionScore')) {
				if (sessionGroup) {
					value = player.getActionsBySessionGroup(sessionGroup).size()
				} else {
					value = player.getActionsByTeam(team).size()
				}
			} else if (criteria.equals('actionByRound')) {
				def actions, rounds
				if (sessionGroup) {
					actions = player.getActionsBySessionGroup(sessionGroup).size()
					rounds = player.getRoundsBySessionGroup(sessionGroup).size()
				} else {
					actions = player.getActionsByTeam(team).size()
					rounds = player.getRoundsByTeam(team).size()
				}
				if (rounds > 0) {
					value = actions / rounds
				}
			} else if (criteria.equals('votingScore')) {
				//TODO change ByTeam
				value = player.getVotingScore()
			} else {
				def status
				if (criteria.equals('statuses.doneGood')) {
					status = Participation.Status.DONE_GOOD.code
				} else if (criteria.equals('statuses.doneBad')) {
					status = Participation.Status.DONE_BAD.code
				} else if (criteria.equals('statuses.undone')) {
					status = Participation.Status.UNDONE.code
				} else if (criteria.equals('statuses.removed')) {
					status = Participation.Status.REMOVED.code
				}
				if (sessionGroup) {
					value = player.getParticipationsByStatusAndSessionGroup(status, sessionGroup).size()
				} else {
					value = player.getParticipationsByStatusAndTeam(status, team).size()
				}
			}
			def x
			if (sessionGroup) {
				x = player.getEffectiveParticipationsBySessionGroup(sessionGroup).size()
			} else {
				x = player.getEffectiveParticipationsByTeam(team).size()
			}
			if (x >= MIN_PARTS_FOR_AVERAGE_SCORING ||
					(!criteria.equals('actionByRound') && !criteria.equals('successRatio'))) {
					memberMap.put(player, value)
			}
		}
		def memberSortedMap = sortMapByValue(memberMap)
		return memberSortedMap
	}

	// TODO redo that ugly method
	static private Map sortMapByValue(Map map) {
		List list = new LinkedList(map.entrySet());
		Collections.sort(list, new Comparator() {
			 public int compare(Object o1, Object o2) {
				  return ((Comparable) ((Map.Entry) (o2)).getValue())
				 .compareTo(((Map.Entry) (o1)).getValue());
			 }
		});
	   Map result = new LinkedHashMap();
	   for (Iterator it = list.iterator(); it.hasNext();) {
		   Map.Entry entry = (Map.Entry)it.next();
		   result.put(entry.getKey(), entry.getValue());
	   }
	   return result;
   }

}
