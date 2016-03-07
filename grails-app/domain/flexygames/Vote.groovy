package flexygames

class Vote implements Comparable<Vote> {
    
    int score
    
    static belongsTo = [user: User, player: User, session: Session]

    static constraints = {
    }
	
	int compareTo(Vote o) {
		int i = this.session.compareTo(o.session)
		if (i != 0) return i
		i = this.player.compareTo(o.player)
		if (i != 0) return i
		i = o.score.compareTo(o.score)
		if (i != 0) return i
		return this.user.compareTo(o.user)
	}
    
}
