package flexygames

import java.util.Set;

import org.apache.shiro.SecurityUtils

class SessionGroup implements Comparable<SessionGroup> {
    
    String name
    String description
	Boolean competition = false
	Boolean visible = true
	GameType defaultType
    Playground defaultPlayground
    int defaultDayOfWeek
    int defaultMinPlayerNbr
    int defaultMaxPlayerNbr
    int defaultPreferredPlayerNbr
	int lockingTime // Time in minutes before the session start while session is locked (ie. user cannot update their status)
	
	SortedSet<Session> sessions
	SortedSet<Team> defaultTeams
	
	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////
	
	static belongsTo = flexygames.Team
    
    static hasMany = [sessions: Session, defaultTeams: Team/*, defaultManagers: User*/]
    
    static constraints = {
        name(nullable: false, blank: true)
        description(nullable: true, blank: true, maxSize:100)
		competition(nullable: false)
		visible(nullable: false)
		sessions(nullable: true)
		defaultType(nullable: false)
        defaultTeams(nullable: true)
        //defaultManagers(nullable: true)
        defaultPlayground(nullable: true)
        defaultDayOfWeek(nullable: true)
        defaultMinPlayerNbr(min:1)
        defaultMaxPlayerNbr(min:1)
        defaultPreferredPlayerNbr(min:1)
		lockingTime(min:0)
    }
	
	static mappedBy = [ defaultTeams: 'sessionGroups' ]
	
	static mapping = {
		sort "name"
		sessions sort: 'date', order: 'desc'
		defaultTeams lazy: false, batchSize: 50
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////

	boolean isVisibleByUsername(String username) {
		if (this.visible) return true
		Set<User> members = getRelatedMembers()
		for (User user : members) {
			if (user.getUsername().equals(username)) return true
		}
		return false
	}
	
	Set<User> getRelatedMembers() {
		User.createCriteria().list {
			memberships {
				'in' 'team.id', defaultTeams*.id
			}
			order 'username', 'asc'
		}
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
		def managed = false
		this.defaultTeams.each { team ->
			if (team.managers.contains(user)) {
				managed = true
			}
		}
		return managed
	}
    
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
    public String toString() {
        return name
    }
	
	public boolean equals (Object o) {
		if (o instanceof SessionGroup) {
			return o.getId() == this.getId()
		} else {
			return false
		}
	}

	public int compareTo (SessionGroup o) {
		if (defaultTeams.size() > 0 && o.defaultTeams.size() > 0) {
			int i = defaultTeams.first().compareTo(o.defaultTeams.first())
			if (i != 0) return i
		}
		return name.compareTo(o.name)
	}
}
