package flexygames

import org.apache.shiro.SecurityUtils
import com.lucastex.grails.fileuploader.UFile


class Team implements Comparable {

	String name
	String description
	String city
	String webUrl
	String email
	UFile logo
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
		sessionGroups lazy: false, batchSize: 50
		//defaultSessionGroup join:'fetch'
	}

	static transients = ['members', 'managers', 'sessions', 'allParticipationCount', 'allEffectiveParticipationCount', 'sessionFactory']

	static constraints = {
		name(blank: true, unique: true)
		description(nullable:true, blank: true, maxSize:100)
		city(nullable: true)
		webUrl(nullable: true, url: true)
		email(nullable: true, email: true)
		logo(nullable: true)
		defaultSessionGroup(nullable: true)
		memberships(nullable: true)
		sessionGroups(nullable: true)
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////

	List<User> getMembers() {
		long t1 = System.currentTimeMillis();
		// Trying to find the less slow method but in fact the problem is more in the user loading (User has many eager collections) 
		//def users = getMembersWithCriteria()	// 11900ms
		//def users = getMembersWithWhereQueries // 11500ms
		def users = getMembersWithHQL() // 11500ms
		//def users = getMembersWithSQL() // 14000ms !?!
		long t2 = System.currentTimeMillis();
		//println "getMembers() : " + (t2 -t1) + " ms for " + users.size() + " members of " + this.toString()
		return users
	}

	List<User> getMembersWithCriteria() {
		User.createCriteria().list {
			memberships { 
				eq 'team.id', this.id 
			}
			// testing
			fetchMode "memberships", org.hibernate.FetchMode.SELECT
			fetchMode "teams", org.hibernate.FetchMode.SELECT
			order 'username', 'asc'
		}
	}
	
	List<User> getMembersWithWhereQueries() {
		User.where {
			memberships {
				eq 'team.id', this.id
			}
		}.list(order:'username')
	}
	
	List<User> getMembersWithHQL() {
		// attention la requete suivante ne renvoie pas une liste de User mais d'une paire User/Membership !
		//User.findAll(" from User as user inner join user.memberships as membership with membership.team.id = " + this.id + ")")
		User.executeQuery(" select user from User as user inner join user.memberships as membership with membership.team.id = " + this.id + " order by username")
	}
	
	List<User> getMembersWithSQL() {
		long t1 = System.currentTimeMillis();
		def userz = systemService.sql.rows("select u.id, u.username from uzer u, membership m where u.id = m.user_id and m.team_id = " + this.id);
		long t2 = System.currentTimeMillis();
		println "getMembers() : " + (t2 -t1) + " ms for " + userz.size() + " members of " + this.toString() + " (SQL part)"
		def userIds = userz.collect {it[0]}
		def users = User.getAll(userIds)
		return users
	}

	List<User> getManagers() {
		def users = User.createCriteria().list {
			memberships { 
				eq 'team.id', this.id 
				eq 'manager', true
			}
			order 'username', 'asc'
		}
		return users
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
		if (managers.contains(user)) {
			return true
		}
		return false
	}

	int countSessions() {
		if (!sessionGroups) return 0
		return Session.countByGroupInList(sessionGroups)
	}

	List<Session> getSessions(params) {
		return Session.findAllByGroupInList(sessionGroups, [sort:params.sort, order:params.order, max:params.max, offset:params.offset])
	}

	def getBlogEntriesForAllMembers(params) {
		def members = this.getMembers();
		BlogEntry.findAllByUserInList(members, params)
	}

	List<Session> getSessionGroups(competition) {
		def result = []
		sessionGroups.each{ g ->
			if ( (competition && g.competition) || (!competition && !g.competition) )
				result << g
		}
		return result
	}

	List<Session> getAllEffectiveSessions() {
		def result = []
		Session.findAllByGroupInList(sessionGroups, [sort:"date", order:"desc"]).each{
			if (it.isEffective()) {
				result << it
			}
		}
		return result
	}

	List<Session> getAllEffectiveSessionsOld() {
		def result = []
		sessionGroups.each{ g ->
			Session.findAllByGroup(g, [sort:"date", order:"desc"]).each{
				if (it.isEffective()) {
					result << it
				}
			}
		}
		return result
	}
	
	int getAllParticipationCount () {
		if (sessionGroups.size() == 0) {
			return 0
		}
		def q = Participation.where {
			session.group in sessionGroups
		}
		return q.count()
	}
	
	int getAllEffectiveParticipationCount () {
		def q = Participation.where {
			(session.group in sessionGroups) && (statusCode == Participation.Status.DONE_GOOD.code || statusCode == Participation.Status.DONE_BAD.code)
		}
		return q.count()
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
