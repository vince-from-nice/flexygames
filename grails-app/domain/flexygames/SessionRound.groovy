package flexygames

import java.awt.List;

class SessionRound /*implements Comparable<SessionRound> */{

	SortedSet<User> playersForTeamA
	SortedSet<User> playersForTeamB

	public enum Result {
		WON_BY_TEAM_A,
		WON_BY_TEAM_B,
		DRAW
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////
	
	static belongsTo = [session: Session]

	static hasMany = [playersForTeamA: User, playersForTeamB: User, actions: GameAction]

	static mapping = {
		actions lazy: true, batchSize: 50, cascade: "all-delete-orphan"
		playersForTeamA lazy: true, batchSize: 50
		playersForTeamB lazy: true, batchSize: 50
	}
	
	static constraints = {
		session()
		playersForTeamA(nullable: true)
		playersForTeamB(nullable: true)
	}
	
	static transients = ['result']
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////

	
	def getActionsByTeam(teamA) {
		def result = []
		// add attribued actions
		def players = teamA ? playersForTeamA : playersForTeamB
		actions.each{ action -> 
			if (action.mainContributor != null && players.contains(action.mainContributor)) result << action 
		}
		// add unattribued actions
		actions.each{ action -> 
			if (action.mainContributor == null && action.forFirstTeamIfOrphelin == teamA) result << action 
		}
		return result
	}

	public Result getResult() {
		// TODO should optimize it, maybe with persistent results (ie. saved into DB)
		def scoreTeamA = getActionsByTeam(true).size()
		def scoreTeamB = getActionsByTeam(false).size()
		if (scoreTeamA > scoreTeamB) {
			return Result.WON_BY_TEAM_A
		} else if (scoreTeamA < scoreTeamB) {
			return Result.WON_BY_TEAM_B
		} else {
			return Result.DRAW
		}
	}
	
	Set<GameAction> getActionsByMainContributor(User p) {
		return GameAction.findAllBySessionRoundAndMainContributor(this, p)
	}
	
	Set<GameAction> getUnattribuedActions(Boolean forFirstTeam) {
		// works only with Grails 2.0 because more than 2 args
		//return GameAction.findAllBySessionRoundAndMainContributorIsNullAndForFirstTeamIfOrphelin(this, forFirstTeam)
		def c = GameAction.createCriteria()
		return c {
			eq("sessionRound", this)
			isNull("mainContributor")
			eq("forFirstTeamIfOrphelin", forFirstTeam)
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
	//	public int compareTo (Object o) {
	//		if (o instanceof SessionRound && o.session == o.session) {
	//			return o.index.compareTo (o.index)
	//		}
	//		else return -1
	//	}
}
