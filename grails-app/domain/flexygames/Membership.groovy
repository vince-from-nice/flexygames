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
		subscriptions lazy: true // no need to load them
	}
	
	public int compareTo (Membership o) {
		return user.compareTo(o.user)
	}
	
	String toString() {
		return "Membership of $user in $team"
	}
}
