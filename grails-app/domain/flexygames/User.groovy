package flexygames

import java.util.regex.Matcher
import java.util.regex.Pattern

import javax.servlet.http.HttpSessionBindingEvent
import javax.servlet.http.HttpSessionBindingListener

import com.lucastex.grails.fileuploader.UFile

class User implements Comparable<User>, HttpSessionBindingListener {

    String username
    String passwordHash
    String firstName
    String lastName
    String email
    String phoneNumber
    String company
	String city
    Integer yearBirthDate
	Date registrationDate
	UFile avatar
	String passwordResetToken
	Date passwordResetExpiration
	Date lastLogin
	Date lastLogout
	String calendarToken
	int scoreInCurrentSession // transient
	Integer partCounter
	Integer absenceCounter
	Integer gateCrashCounter
	Integer actionCounter
	Integer voteCounter
	Integer commentCounter

	SortedSet<flexygames.Role> roles
	SortedSet<Membership> memberships
    SortedSet<GameSkill> skills
	SortedSet<Participation> participations
	Set<GameAction> actions
	Set<Vote> votes
	
	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////

    // TODO clarify many-to-many associations with Team and Session
    //static belongsTo = Team
	
    static hasMany = [roles: Role, permissions: String, memberships: Membership, 
		skills: GameSkill, participations: Participation, actions: GameAction, votes: Vote]

    static mappedBy = [teams: "members", managedTeams: "managers", actions: "mainContributor"]

	static mapping = {
		table 'uzer'
		avatar fetch: 'join'
		memberships lazy: true
		participations lazy: true, batchSize: 50
		skills lazy: true
		actions lazy: true
		votes lazy: true
		memberships cascade: "all-delete-orphan"
	}

	static transients = [ 'scoreInCurrentSession', 'relatedSessions', 'sessionGroups', 'teams', 
		 'wins', 'defeats', 'draws', 'rounds', 'votingScore', 'actionScore', 'effectiveParticipations' ]
	
	public static Pattern USERNAME_VALID_CHARS = Pattern.compile("[A-Za-zéÉèÈôÔçÇ0-9_\\-]+");

    static constraints = {
        username(nullable: false, blank: false, unique: true, minSize: 2, 
			validator: {val -> Matcher m = USERNAME_VALID_CHARS.matcher(val); m.matches()})
        //passwordHash(nullable: false, blank: false)
		roles(nullable:false, minSize:1)
        firstName(nullable: true, blank: true)
        lastName(nullable: true, blank: true)
        email(nullable: false, blank: false, email: true, unique: true)
        phoneNumber(nullable: true, blank: true)
        company(nullable: true, blank: true)
		city(nullable: true, blank: true)
        yearBirthDate(nullable: true, range:1950..2012)
        registrationDate(nullable: false)
		avatar(nullable: true)
        memberships(nullable: true)
        skills(nullable: true)
        participations(nullable: true)
        actions(nullable: true)
		passwordResetToken(nullable: true)
		passwordResetExpiration(nullable: true)
		lastLogin(nullable: true)
		lastLogout(nullable: true)
		calendarToken(nullable: true)
		partCounter(nullable: true)
		absenceCounter(nullable: true)
		gateCrashCounter(nullable: true)
		actionCounter(nullable: true)
		voteCounter(nullable: true)
		commentCounter(nullable: true)
    }

	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////
	
	List<User> getTeams() {
		def teams = Team.createCriteria().list {
			memberships {
				eq ('user.id', this.id)
			}
			order 'name', 'asc'
		}
		return teams
	}
	
	List<SessionGroup> getRelatedSessions(Date start, Date end) {
		def result = []
		getSessionGroups().each { group ->
			group.sessions.each {
				if ((start == null || it.date > start ) && (end == null || it.date < end )) {
					result << it
				}
			}
		}
		result = result.sort{ it.date }
		return result
	}
	
	boolean isParticipantOf(Session session) {
		return session.participations.findIndexOf  { it.player == this} 
	}
	
	boolean isManagedBy(String username) {
		boolean result = false
		if (!username) return false
		User user = User.findByUsername(username)
		teams.each { team ->
			if (team.managers.contains(user)) result = true
		}
		return result
	}
	
	boolean isWatchingSession(Session s) {
		return SessionWatch.findByUserAndSession(this, s) != null
	}
	
	Membership getMembershipByTeam(Team team) {
		// Les memberships ne sont pas chargés par défaut (malgré le lazy:false comme mapping !!) donc on refait une requete :(
		//println "Checking $team for $this who has " + this.memberships.size() + " membership(s)"
//		for (Membership ms : memberships) {
//			if (ms.team.equals(team)) return ms
//		}
//		return null
		return flexygames.Membership.findByUserAndTeam(this, team)
	}
	
	SortedSet<SessionGroup> getSessionGroups() {
		SortedSet<SessionGroup> result = new TreeSet<SessionGroup>()
		teams.each { team ->
			team.sessionGroups.each { group -> 
				result << group
			}
		}
		return result
	}

	List<Participation> getParticipationsVisibleInCalendar() {
		def result = []
		long now = java.lang.System.currentTimeMillis() 
		allParticipations.each { p ->
			// sessions in the past 
			if (p.session.date.time < now) {
				if (p.statusCode == Participation.Status.DONE_GOOD.code || p.statusCode == Participation.Status.DONE_BAD.code) {
					result << p
				}
			}
			// sessions in the future 
			else {
				if (p.statusCode == Participation.Status.REQUESTED.code || p.statusCode == Participation.Status.AVAILABLE.code || 
					p.statusCode == Participation.Status.APPROVED.code || p.statusCode == Participation.Status.WAITING_LIST.code) {
					result << p
				}
			}
		}
		return result
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Stats methods (need to move them)
	///////////////////////////////////////////////////////////////////////////
	
	def getActionsBySessionRound(SessionRound sr) {
		def result = []
		actions.each{ action ->
			if (action.sessionRound.id == sr.id) {
				result << action
			}
		}
		return result
	}
	
	def getActionsBySessionGroup(SessionGroup group) {
		def result = []
		actions.each{ action ->
			if (group.id in action.sessionRound.session.group.id) {
				result << action
			}
		}
		return result
	}
	
	def getActionsByTeam(Team team) {
		def result = []
		actions.each{ action ->
			if (team.id in action.sessionRound.session.group.defaultTeams*.id) {
				result << action
			}
		}
		return result
	}
	
	int countAllActiveParticipations() {
		return Participation.countByPlayerAndStatusCodeNotEqual(this, Participation.Status.REQUESTED.code)
	}
	
	List<Participation> getActiveParticipations(paramz) {
		return Participation.findAllByPlayerAndStatusCodeNotEqual(this, Participation.Status.REQUESTED.code, [sort: "session.date", order:'desc', offset: paramz.offset, max: paramz.max])
	}
	
	List<Participation> getEffectiveParticipations() {
		def result = []
		allParticipations.each { p ->
			if (p.isEffective()) {
				result << p
			}
		}
		return result
	}
	
	List<Participation> getEffectiveParticipationsBySessionGroup(group) {
		def result = []
		effectiveParticipations.each { p ->
			if (group.id in p.session.group.id) {
				result << p
			}
		}
		return result
	}
	
	List<Participation> getEffectiveParticipationsByTeam(Team team) {
		def result = []
		effectiveParticipations.each { p ->
			if (team.id in p.session.group.defaultTeams*.id) {
				result << p
			}
		}
		return result
	}
	
	List<Participation> getParticipationsByStatus(String statusCode) {
		Participation.findAllByPlayerAndStatusCode(this, statusCode, [sort: "session.date", order:'desc'])
	}
	
	int countParticipationsByStatus(String statusCode) {
		Participation.countByPlayerAndStatusCode(this, statusCode)
	}
	
	List<Participation> getParticipationsByStatusAndTeam(String statusCode, Team team) {
		def result = []
		getParticipationsByStatus(statusCode).each { p ->
			if (team.id in p.session.group.defaultTeams*.id) {
				result << p
			}
		}
		return result
	}

	List<Participation> getParticipationsByStatusAndSessionGroup(String statusCode, SessionGroup sessionGroup) {
		def result = []
		getParticipationsByStatus(statusCode).each { p ->
			if (sessionGroup.id == p.session.group.id) {
				result << p
			}
		}
		return result
	}
	
	List<SessionRound> getRounds() {
		def result = []
		getAllParticipations().each{ p ->
			p.session.rounds.each { r ->
				if (this in r.playersForTeamA || this in r.playersForTeamB) result << r
			}
		}
		return result
	}
	
	List<SessionRound> getRoundsByTeam(team) {
		def result = []
		getAllParticipations().each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) {
				p.session.rounds.each { r ->
					if (this in r.playersForTeamA || this in r.playersForTeamB) result << r
				}
			}
		}
		return result
	}
	
	List<SessionRound> getRoundsBySessionGroup(group) {
		def result = []
		getAllParticipations().each{ p ->
			if (group.id == p.session.group.id) {
				p.session.rounds.each { r ->
					if (this in r.playersForTeamA || this in r.playersForTeamB) result << r
				}
			}
		}
		return result
	}
	
	List<SessionRound> getWins() {
		def result = []
		getAllParticipations().each{ p ->
			result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDraws() {
		def result = []
		getAllParticipations().each{ p ->
			result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeats() {
		def result = []
		getAllParticipations().each{ p ->
			result += p.defeats
		}
		return result
	}
	
	List<SessionRound> getWinsByTeam(team) {
		def result = []
		getAllParticipations().each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDrawsByTeam(team) {
		def result = []
		getAllParticipations().each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeatsByTeam(team) {
		def result = []
		getAllParticipations().each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.defeats
		}
		return result
	}
	
	List<SessionRound> getWinsBySessionGroup(group) {
		def result = []
		getAllParticipations().each{ p ->
			if (group.id == p.session.group.id) result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDrawsBySessionGroup(group) {
		def result = []
		getAllParticipations().each{ p ->
			if (group.id == p.session.group.id) result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeatsBySessionGroup(group) {
		def result = []
		getAllParticipations().each{ p ->
			if (group.id == p.session.group.id) result += p.defeats
		}
		return result
	}
	
	def getVotingScore() {
		int score = 0
		getAllParticipations().each{ p ->
			score += p.votingScore
		}
		return score
	}
	
	def getVotingScoreByTeam(team) {
		int score = 0
		getAllParticipations().each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) score += p.votingScore
		}
		return score
	}
	
	def getVotingScoreBySessionGroup(group) {
		int score = 0
		getAllParticipations().each{ p ->
			if (group.id == p.session.group.id) score += p.votingScore
		}
		return score
	}
	
	// damned pourquoi le SortedSet "participations" ne se remplit qu'avec une seul �lement ? Evidemment passer en lazy:false ne change rien alors on le fait � la main :(
	List<Team> getAllParticipations() {
		Participation.findAllByPlayer(this, [sort: "session.date", order:'desc'])
	}
	
	// damned la m�me chose !
	List<Membership> getAllMemberships() {
		Membership.findAllByUser(this, [sort: "team.name", order:'asc'])
	}
	
	// damned la m�me chose !
	List<Vote> getAllVotes() {
		Vote.findAllByPlayer(this, [sort: "session.name", order:'asc'])
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Counter methods for fast computed statistics
	///////////////////////////////////////////////////////////////////////////
	
	// Participation counter 
	
	int countParticipations() {
		if (this.partCounter == null) {
			this.partCounter = getEffectiveParticipations().size()
			if (!this.save(flush: true)) {
				println "Error when initializing the participation counter for $this : " + this.errors
			} else {
				println "Participation counter for $this has been initialized"
			}
		}
		return this.partCounter
	}

	def updatePartCounter (int offset) {
		this.partCounter = countParticipations() + offset
		return this.save()
	}
	
	// Absence counter
	
	int countAbsences() {
		if (this.absenceCounter == null) {
			this.absenceCounter = countParticipationsByStatus(Participation.Status.UNDONE.code)
			if (!this.save(flush: true)) {
				println "Error when initializing the absence counter for $this : " + this.errors
			} else {
				println "Absence counter for $this has been initialized"
			}
		}
		return this.absenceCounter
	}

	def updateAbsenceCounter (int offset) {
		this.absenceCounter = countAbsences() + offset
		return this.save()
	}
	
	// Gatecrash counter
	
	int countGateCrashes() {
		if (this.gateCrashCounter == null) {
			this.gateCrashCounter = countParticipationsByStatus(Participation.Status.DONE_BAD.code)
			if (!this.save(flush: true)) {
				println "Error when initializing the gatecrash counter for $this : " + this.errors
			} else {
				println "Gatecrash counter for $this has been initialized"
			}
		}
		return this.gateCrashCounter
	}

	def updateGateCrashCounter (int offset) {
		this.gateCrashCounter = countGateCrashes() + offset
		return this.save()
	}

	// Comment counter
	
	int countComments() {
		if (this.commentCounter == null) {
			this.commentCounter = SessionComment.findAllByUser(this).size()
			if (!this.save(flush: true)) {
				println "Error when initializing the comment counter for $this : " + this.errors
			} else {
				println "Comment counter for $this has been initialized"
			}
		}
		return this.commentCounter
	}
	
	def updateCommentCounter (int offset) {
		this.commentCounter = countComments() + offset
		return this.save()
	}
	
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
	public boolean equals (Object o) {
		if (o instanceof User) {
			return o.getUsername() == this.getUsername()
		}
		return false
	}
	
    public int compareTo (Object o) {
        if (o instanceof User) {
            return this.getUsername().toLowerCase().compareTo(o.getUsername().toLowerCase())
        }
        else return -1
    }

    public String toString() {
        return getUsername()
    }
	
	void valueBound(HttpSessionBindingEvent event) {
		def onlineUsers = event.session.servletContext.onlineUsers
		if (!onlineUsers.contains(this)) onlineUsers.add(this)
		println "User $username is logged in"
		lastLogin = new Date()
		if (!this.save()) println "Unable to update last login for $username"
	}
	
	void valueUnbound(HttpSessionBindingEvent event) {
		def onlineUsers = event.session.servletContext.onlineUsers
		if (onlineUsers.contains(this)) onlineUsers.remove(this)
		println "User $username is logged out"
		//lastLogout = new Date()
		//if (!this.save()) println "Unable to update last logout for $username"
	}

}
