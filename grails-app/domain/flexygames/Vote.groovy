package flexygames

class Vote implements Comparable<Vote> {
    
    int score
    
    static belongsTo = [user: User, player: User, session: Session]

    static constraints = {
    }
	
	int compareTo(Vote o) {
		int i = this.session.compareTo(o.session)
		if (i != 0) return i
		else {
			int j = this.player.compareTo(o.player)
			if (j != 0) return j
			else return o.score.compareTo(o.score)
		}
	}
    
}
