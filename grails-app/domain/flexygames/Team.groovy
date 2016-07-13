package flexygames

import org.apache.shiro.SecurityUtils


class Team implements Comparable {

	String name
	String description
	String city
	String webUrl
	String email
	String logoName = 'no-logo.png'
	SessionGroup defaultSessionGroup
	
	SortedSet<Membership> memberships
	SortedSet<SessionGroup> sessionGroups
	
	// For testing SQL queries
	//def systemService
	
	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////
	
	static hasMany = [memberships: Membership, sessionGroups: SessionGroup]
	
//	static belongsTo = [User, User]

	static mappedBy = [
//		members: "teams", 
//		managers: "managedTeams",
//		sessionGroups: "defaultTeams"
	]

	static mapping = {
		memberships lazy: true, batchSize: 50, cascade: "all-delete-orphan"
		sessionGroups lazy: true, batchSize: 50
		//defaultSessionGroup join:'fetch'
	}

	static transients = ['members', 'managers', 'sessions', 'allParticipationCount', 'allEffectiveParticipationCount', 'sessionFactory']

	static constraints = {
		name(blank: true, unique: true)
		description(nullable:true, blank: true, maxSize:100)
		city(nullable: true)
		webUrl(nullable: true, url: true)
		email(nullable: true, blank: true, email: true)
		logoName(nullable: true)
		defaultSessionGroup(nullable: true)
		memberships(nullable: true)
		sessionGroups(nullable: true)
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////

	List<User> getMembers() {
		return memberships*.user
	}

	List<User> getManagers() {
		def result = []
		memberships.each { membership ->
			if (membership.manager) {
				result << membership.user
			}
		}
		return result
	}

	boolean isManagedBy(String username) {
		User user
		if (username) user = User.findByUsername(username)
		if (!user) {
			return false
		}
		if (SecurityUtils.subject.hasRole("Administrator")) {
			return true
		}
		if (getManagers().contains(user)) {
			return true
		}
		return false
	}

	int countSessions() {
		if (!sessionGroups) return 0
		return Session.countByGroupInList(sessionGroups)
	}

	List<Session> getSessions() {
		return Session.findAllByGroupInList(sessionGroups)
	}

	List<Session> getSessions(params) {
		return Session.findAllByGroupInList(sessionGroups, [sort:params.sort, order:params.order, max:params.max, offset:params.offset])
	}

	def getBlogEntriesForAllMembers(params) {
		def members = this.getMembers();
		BlogEntry.findAllByUserInList(members, params)
	}

	def getBlogEntries(params) {
		BlogEntry.findAllByTeam(this, params)
	}

	List<Session> getSessionGroups(competition) {
		def result = []
		sessionGroups.each{ g ->
			if ( (competition && g.competition) || (!competition && !g.competition) )
				result << g
		}
		return result
	}

	int countAllParticipations() {
		if (sessionGroups.size() == 0) {
			return 0
		}
		def q = Participation.where {
			session.group in sessionGroups
		}
		return q.count()
	}
	
	int countAllEffectiveParticipations() {
		if (sessionGroups.size() == 0) return 0
		def q = Participation.where {
			(session.group in sessionGroups) && (statusCode == Participation.Status.DONE_GOOD.code || statusCode == Participation.Status.DONE_BAD.code)
		}
		return q.count()
	}

	int countAllEffectiveSessions() {
		int result
		if (sessionGroups.size() == 0) return 0
		def q = Participation.where {
			(session.group in sessionGroups) && (statusCode == Participation.Status.DONE_GOOD.code() || statusCode == Participation.Status.DONE_BAD.code())
		}
		def allEffectiveParticipations = q.list()
		Set<Session> allEffectiveSessions = new HashSet<>()
		allEffectiveParticipations.each { part ->
			allEffectiveSessions << part.session
		}
		return allEffectiveSessions.size()
	}
	
	SessionGroup getSessionGroupByDefault() {
		if (defaultSessionGroup) {
			return defaultSessionGroup
		}
		if (sessionGroups && sessionGroups.size() > 0) { return sessionGroups.last() }
		else return null
	}
	
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
	public String toString() {
		return name
	}

	public boolean equals (Object o) {
		if (o instanceof Team) {
			return o.name == name
		} else {
			return false
		}
	}

	int compareTo(Object o) {
		if (o instanceof Team) {
			return name.compareTo(o.name)
		} else {
			return -1
		}
	}
}
