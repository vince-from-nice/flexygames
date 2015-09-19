package flexygames

import java.util.Map;

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
			if (team.getSessionGroups(true).size() > 0) {
				params.mode = "competition"
			} else {
				params.mode = "training"
			}
		}
		if (params.mode == "ranking") {
			def criteria = (params.criteria ? params.criteria : 'statuses.doneGood')
			 [teamInstance: team, members: getMembersTreeForRanking(params, team, criteria), currentCriteria: criteria]
		} else {
			[teamInstance: team]
		}
	}
	
	// TODO redo that ugly method
	def private getMembersTreeForRanking(params, Team team, String criteria) {
		TreeMap<User, Number> memberMap = new TreeMap<User, Number> ()
		// TODO make it customizable
		def MIN_PARTS_FOR_AVERAGE_SCORING = 10
		def members = team.members
		members.each { player ->
			def value = 0
			if (criteria.equals('successRatio')) {
				def wins = player.getWinsByTeam(team).size()
				def parts = wins + player.getDrawsByTeam(team).size() + player.getDefeatsByTeam(team).size()
				if (parts > 0) {
					value = wins / parts
				}
			} else if (criteria.equals('statuses.doneGood')) {
				value = player.getParticipationsByStatusAndTeam(Participation.Status.DONE_GOOD.code, team).size()
			} else if (criteria.equals('statuses.doneBad')) {
				value = player.getParticipationsByStatusAndTeam(Participation.Status.DONE_BAD.code, team).size()
			} else if (criteria.equals('statuses.undone')) {
				value = player.getParticipationsByStatusAndTeam(Participation.Status.UNDONE.code, team).size()
			} else if (criteria.equals('statuses.removed')) {
				value = player.getParticipationsByStatusAndTeam(Participation.Status.REMOVED.code, team).size()
			} else if (criteria.equals('actionScore')) {
				value = player.getActionsByTeam(team).size()
			} else if (criteria.equals('actionByRound')) {
				def rounds = player.getRoundsByTeam(team).size()
				if (rounds > 0) {
					value = player.getActionsByTeam(team).size() / player.getRoundsByTeam(team).size()
				}
			} else if (criteria.equals('votingScore')) {
				value = player.getVotingScore() // TODO change ByTeam
			}
			def x = player.getEffectiveParticipationsByTeam(team).size()
			if (x > MIN_PARTS_FOR_AVERAGE_SCORING ||
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
