package flexygames

import java.util.regex.Matcher
import java.util.regex.Pattern

import javax.servlet.http.HttpSessionBindingEvent
import javax.servlet.http.HttpSessionBindingListener

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
	String avatarName
	String passwordResetToken
	Date passwordResetExpiration
	Date lastLogin
	Date lastLogout
	String calendarToken
	Integer partCounter
	Integer absenceCounter
	Integer gateCrashCounter
	Integer actionCounter
	Integer voteCounter
	Integer commentCounter

	int scoreInCurrentSession // transient
	Membership membershipInCurrentSession // transient
	SortedSet<Team> teamsInCurrentSession = new TreeSet<Team>() // transient

	SortedSet<Role> roles
	SortedSet<Membership> memberships
    SortedSet<GameSkill> skills
	SortedSet<Participation> participations
	Set<GameAction> actions
	Set<Vote> votes
	Set<Vote> receivedVotes

	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////

    // TODO clarify many-to-many associations with Team and Session
    //static belongsTo = Team
	
    static hasMany = [roles: Role, permissions: String, memberships: Membership, 
		skills: GameSkill, participations: Participation, actions: GameAction, votes: Vote, receivedVotes: Vote]

    static mappedBy = [actions: "mainContributor", votes: "user", receivedVotes: "player"]

	static mapping = {
		table 'uzer'
		//cache true
		memberships lazy: true, batchSize: 50, cascade: "all-delete-orphan"
		participations lazy: true, batchSize: 50
		skills lazy: true, batchSize: 50
		actions lazy: true, batchSize: 50
		votes lazy: true, batchSize: 50
		receivedVotes lazy: true, batchSize: 50
	}

	static transients = [ 'scoreInCurrentSession', 'membershipInCurrentSession', 'teamsInCurrentSession',
						  'allSubscribedTeams', 'allSubscribedSessionGroups', 'allSessions',
						  'wins', 'defeats', 'draws', 'rounds', 'votingScore', 'actionScore', 'effectiveParticipations' ]

	// Be careful with the character encoding:
	// - following line is ok in ANSI or ISO-8859
	//public static Pattern USERNAME_VALID_CHARS = Pattern.compile("[A-Za-z��������0-9_\\-]+");
	// - following line is ok in UTF-8:
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
		avatarName(nullable: true, blank: false)
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

	def getEffectiveParticipations = {
		return participations.grep{it.isEffective()}
	}

	def getAllEffectiveSessions = {
		return getEffectiveParticipations()*.session
	}

	// Calculate all session groups the player has participated to (not only the groups of the team he has subscribed to)
	def getAllEffectiveSessionGroups = {
		SortedSet<SessionGroup> allSessionGroups = new TreeSet<>()
		getAllEffectiveSessions().each{allSessionGroups << it.group}
		return allSessionGroups
	}

	def getAllSubscribedTeams() {
		return memberships*.team
	}

	// TODO redo with one big request
	SortedSet<SessionGroup> getAllSubscribedSessionGroups() {
		SortedSet<SessionGroup> result = new TreeSet<SessionGroup>()
		// ERROR spi.SqlExceptionHelper  - Not specified value for parameter 1
//		def teams = getAllSubscribedTeams()
//		SortedSet<SessionGroup> result = SessionGroup.findAllByDefaultTeamsInList(teams)
		def teams = getAllSubscribedTeams()
		teams.each { team ->
			team.sessionGroups.each { group ->
				result << group
			}
		}
		return result
	}

	// TODO redo with one big request
	List<SessionGroup> getAllSubscribedSessions(Date start, Date end) {
		def result = []
		getAllSubscribedSessionGroups().each { group ->
			group.sessions.each {
				if ((start == null || it.date > start ) && (end == null || it.date < end )) {
					result << it
				}
			}
		}
		result = result.sort{ it.date }
		return result
	}

	boolean isManagedBy(String username) {
		boolean result = false
		if (!username) return false
		User user = User.findByUsername(username)
		allSubscribedTeams.each { team ->
			if (team.managers.contains(user)) result = true
		}
		return result
	}
	
	boolean isWatchingSession(Session s) {
		return SessionWatcher.findByUserAndSession(this, s) != null
	}

	List<Participation> getParticipationsVisibleInCalendar() {
		def result = []
		long now = System.currentTimeMillis()
		participations.each { p ->
			// sessions in the past 
			if (p.session.date.time < now) {
				if (p.statusCode == Participation.Status.DONE_GOOD.code() || p.statusCode == Participation.Status.DONE_BAD.code()) {
					result << p
				}
			}
			// sessions in the future 
			else {
				if (p.statusCode == Participation.Status.REQUESTED.code() || p.statusCode == Participation.Status.AVAILABLE.code() ||
					p.statusCode == Participation.Status.APPROVED.code() || p.statusCode == Participation.Status.WAITING_LIST.code()) {
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
		return Participation.countByPlayerAndStatusCodeNotEqual(this, Participation.Status.REQUESTED.code())
	}
	
	List<Participation> getActiveParticipations(params) {
		return Participation.findAllByPlayerAndStatusCodeNotEqual(this, Participation.Status.REQUESTED.code(), [sort: "session.date", order:'desc', offset: params.offset, max: params.max])
	}

	List<Participation> getEffectiveParticipationsBySessionGroup(group) {
		def result = []
		getEffectiveParticipations().each { p ->
			if (group.id in p.session.group.id) {
				result << p
			}
		}
		return result
	}
	
	List<Participation> getEffectiveParticipationsByTeam(Team team) {
		def result = []
		getEffectiveParticipations().each { p ->
			if (team.id in p.session.group.defaultTeams*.id) {
				result << p
			}
		}
		return result
	}
	
	SortedSet<Participation> getParticipationsByStatus(String statusCode) {
		//Participation.findAllByPlayerAndStatusCode(this, statusCode, [sort: "session.date", order:'desc'])
		return participations.grep{it.statusCode == statusCode}
	}
	
	int countParticipationsByStatus(String statusCode) {
		Participation.countByPlayerAndStatusCode(this, statusCode)
	}
	
	List<Participation> getParticipationsByStatusAndTeam(String statusCode, Team team) {
		def result = []
		def parts = getParticipationsByStatus(statusCode)
		parts.each { p ->
			//println "\t" + p.session.group.defaultTeams*.id
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

	List<SessionRound> getRoundsByTeam(team) {
		def result = []
		participations.each{ p ->
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
		participations.each{ p ->
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
		participations.each{ p ->
			result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDraws() {
		def result = []
		participations.each{ p ->
			result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeats() {
		def result = []
		participations.each{ p ->
			result += p.defeats
		}
		return result
	}
	
	List<SessionRound> getWinsByTeam(team) {
		def result = []
		participations.each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDrawsByTeam(team) {
		def result = []
		participations.each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeatsByTeam(team) {
		def result = []
		participations.each{ p ->
			if (team.id in p.session.group.defaultTeams*.id) result += p.defeats
		}
		return result
	}
	
	List<SessionRound> getWinsBySessionGroup(group) {
		def result = []
		participations.each{ p ->
			if (group.id == p.session.group.id) result += p.wins
		}
		return result
	}
	
	List<SessionRound> getDrawsBySessionGroup(group) {
		def result = []
		participations.each{ p ->
			if (group.id == p.session.group.id) result += p.draws
		}
		return result
	}
	
	List<SessionRound> getDefeatsBySessionGroup(group) {
		def result = []
		participations.each{ p ->
			if (group.id == p.session.group.id) result += p.defeats
		}
		return result
	}

	def getVotingScore() {
		int score = 0
		receivedVotes.each { v ->
			score += v.score
		}
		return score
	}

	def getVotingScoreByTeam(team) {
		int score = 0
		receivedVotes.each { v ->
			if (team.id in v.session.group.defaultTeams*.id) score += v.score
		}
		return score
	}
	
	def getVotingScoreBySessionGroup(group) {
		int score = 0
		receivedVotes.each { v ->
			if (group.id == v.session.group.id) score += v.score
		}
		return score
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Counter methods for precomputed statistics
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
			this.absenceCounter = countParticipationsByStatus(Participation.Status.UNDONE.code())
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
			this.gateCrashCounter = countParticipationsByStatus(Participation.Status.DONE_BAD.code())
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
	
    public int compareTo (User o) {
		return this.getUsername().toLowerCase().compareTo(o.getUsername().toLowerCase())
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
