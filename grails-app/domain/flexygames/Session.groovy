package flexygames

import com.sun.org.apache.xpath.internal.operations.Bool
import groovy.time.TimeCategory
import org.apache.shiro.SecurityUtils

class Session implements Comparable {

    String name
    String description
    Date date // session start (not RDV)
	Integer duration // time in minutes beetween session start and session end
	Integer rdvBeforeStart // time in minutes beetween rdv and session start
	Integer lockingTime // time in minutes before the session start while session is locked (ie. user cannot update their status)
    Playground playground
    GameType type
    SessionGroup group
	SortedSet<Participation> participations
	SortedSet<Reminder> reminders
	List<SessionRound> rounds
	SortedSet<Vote> votes
	SortedSet<SessionComment> comments
	String imageUrl
	String galleryUrl
	Date creation
	User creator
	Date lastUpdate
	User lastUpdater
	String extraFieldName
	String extraFieldValue
	Boolean canceled
	String cancelationLog
	User cancelationUser
	Date cancelationDate

	SortedSet<Composition> compositions
	SortedSet<Task> tasks
	Set<SessionWatcher> watchers
	SortedSet<CarpoolProposal> carpoolProposals
	SortedSet<CarpoolRequest> carpoolRequests

	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////

	static hasMany = [participations: Participation, reminders: Reminder, rounds: SessionRound, votes: Vote,
					  comments: SessionComment, compositions: Composition, tasks: Task, watchers: SessionWatcher,
					  carpoolRequests: CarpoolRequest, carpoolProposals: CarpoolProposal]

    static constraints = {
		date(nullable: false)
		duration(nullable: true, min: 1)
		rdvBeforeStart(nullable: true, min: 0)
		lockingTime(nullable: true, min: 0)
        name(nullable: true, blank: true)
        description(nullable: true, blank: true, maxSize:100)
        playground(nullable: false)
        type(nullable: false)
        group(nullable: false)
		participations(nullable: true)
		reminders(nullable: true)
        rounds(nullable: true)
		votes(nullable: true)
		comments(nullable: true)
		imageUrl(nullable: true, url:true)
		galleryUrl(nullable: true, url:true)
		creation(nullable: true)
		creator(nullable: true)
		extraFieldName(nullable: true)
		extraFieldValue(nullable: true)
		compositions(nullable: true)
		lastUpdate(nullable: true)
		lastUpdater(nullable: true)
		canceled(nullable: true)
		cancelationLog(nullable: true)
		cancelationUser(nullable: true)
		cancelationDate(nullable: true)
    }
	
    static transients = [
		'effective',
		'managers',
		'approvedParticipants',
		'effectiveParticipants',
		'allVotes',
        'previousSessionInGroup',
        'nextSessionInGroup'
    ]
	
	static mapping = {
		//cache true
		sort date: "desc"
		playground (fetch: 'join')
		type (fetch:'join')
		group (fetch:'join')
		participations lazy: true, batchSize: 50
		reminders lazy: true, batchSize: 50
		rounds lazy: true, batchSize: 50
		votes lazy: true, batchSize: 50
		comments lazy: true, batchSize: 50
		compositions lazy: true, batchSize: 50
		watchers lazy: true, batchSize: 50
	}
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////

    boolean isManagedBy(String username) {
		//println "checking management of $this for user $username"
		//println "group managers are " + group.defaultManagers
        User user
        if (username) user = User.findByUsername(username)
        if (!user) {
            return false
        }
        if (SecurityUtils.subject.hasRole("Administrator")) {
            return true
        }
		def managed = false
        group.defaultTeams.each { team ->
			if (team.managers.contains(user)) {
				managed = true
			}
        }
        return managed
    }
	
	List<User> getManagers() {
		def result = []
		group.defaultTeams.each { team ->
			team.managers.each { manager ->
				result << manager
			}
		}
		return result
	}

	List<User> getParticipantsByStatus(String statusCode) {
		def result = []
		participations.each { p ->
			if (p.statusCode == statusCode) {
				result << p.player
			}
		}
		return result
	}
	
	List<User> getAvailableParticipants() {
		def result = getApprovedParticipants()
		participations.each { p ->
			if (p.statusCode == Participation.Status.AVAILABLE.code || p.statusCode == Participation.Status.WAITING_LIST.code) {
				result << p.player
			}
		}
		return result
	}
	
	List<User> getApprovedParticipants() {
		def result = getEffectiveParticipants()
		participations.each { p ->
			if (p.statusCode == Participation.Status.APPROVED.code || p.statusCode == Participation.Status.APPROVED_EXTRA.code) {
				result << p.player
			}
		}
		return result
	}
	
	List<User> getEffectiveParticipants() {
        def result = []
        participations.each { p ->
            if (p.isEffective()) {
                result << p.player
            }
        }
        return result
    }
	
	List<User> getParticipantsEligibleForComposition() {
		def result = []
		participations.each { p ->
			if (p.statusCode == Participation.Status.AVAILABLE.code || p.statusCode == Participation.Status.APPROVED.code
				|| p.statusCode == Participation.Status.DONE_GOOD.code || p.statusCode == Participation.Status.DONE_BAD.code) {
				result << p.player
			}
		}
		return result
	}

	List<User> getParticipantsEligibleForAttendanceSheet() {
		def result = []
		participations.each { p ->
			if (p.statusCode == p.isEffective() || Participation.Status.UNDONE.code ||
					p.statusCode == Participation.Status.APPROVED.code || p.statusCode == Participation.Status.APPROVED_EXTRA.code) {
				result << p.player
			}
		}
		return result
	}
	
	Participation getParticipationOf(String playerName) {
		if (!playerName) return null
		return Participation.findBySessionAndPlayer(this, User.findByUsername(playerName))
	}
	
	// damned pourquoi le SortedSet "votes" ne se remplit pas avec tous les éléments ?
	List<Team> getAllVotes() {
		Vote.findAllBySession(this, [sort: "user.username", order:'asc'])
	}
	
    Session getNextSessionInGroup() {
        def previous = null
        for (Session session : group.sessions) {
            if(session.id == id) return previous
            previous = session
        }
        return previous
    }

    Session getPreviousSessionInGroup() {
        def found = false
        for (Session session : group.sessions) {
            if (found) return session
            if(session.id == id) found = true
        }
        return null
    }
	
	Date getRdvDate() {
		return (rdvBeforeStart ? new Date(date.time - rdvBeforeStart * 60 * 1000) : date)
	}
	
	Date getEndDate() {
		// If no duration is defined for that session, we default to 60 min
		return (duration ? new Date(date.time + duration * 60 * 1000) : new Date(date.time + 60 * 60 * 1000))
	}

	Date getLockingDate() {
		def lock = lockingTime
		if (!lock) {
			lock = group.defaultLockingTime
		}
		use(TimeCategory) {
			return date - lock.minutes
		}
	}

	int getNumberOfNonApprovedCarpoolRequest() {
		return this.carpoolRequests.grep({!it.driver}).size()
	}
	
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
	public String toString() {
		if (name) return name
		else if (date) return "Session on " + date.toString().substring(0,10)  + " at $playground"
		else return "Null session"
	}
	
	public boolean equals (Object o) {
		if (o instanceof Session) {
			return o.getId() == this.getId()
		} else {
			return false
		}
	}

	int compareTo(Object o) {
		if (o instanceof Session && o != null) {
			int i = o.getDate().compareTo(this.getDate())
			if (i != 0) return i
			else {
				int j = this.getPlayground().compareTo(this.getPlayground())
				if (j != 0) return j
				else {
					return this.getId().compareTo(o.getId())
				}
			}
		} else {
			return -1
		}
	}
}
