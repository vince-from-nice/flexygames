package flexygames

class Membership implements Comparable<Membership> {
	
	User user
	Team team
	SortedSet<Subscription> subscriptions
	Boolean manager
	Boolean regularForTraining
	Boolean regularForCompetition
	Boolean feesUpToDate
	
	static belongsTo = [user: User, team: Team]
	
	static hasMany = [subscriptions: Subscription]

    static constraints = {
		user(unique: 'team')
		team()
		manager()
		regularForTraining()
		regularForCompetition()
		feesUpToDate(nullable: true)
    }
	
	static mapping = {
		//cache true
		user fetch: 'join'
		team fetch: 'join'
		subscriptions lazy: true, batchSize: 50
	}
	
	public int compareTo (Membership o) {
		int i = user.compareTo(o.user)
		if (i != 0) {
			return i
		}
		return team.compareTo(o.team)
	}
	
	String toString() {
		return "Membership of $user in $team"
	}
}
