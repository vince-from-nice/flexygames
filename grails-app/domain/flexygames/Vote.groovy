package flexygames

class Vote implements Comparable<Object> {
    
    int score
    
    static belongsTo = [user: User, player: User, session: Session]
    
    static constraints = {
    }
	
	int compareTo(Object o) {
		if (o instanceof Vote) {
			int i = this.session.compareTo(o.session)
			if (i != 0) return i
			else {
				int j = this.player.compareTo(o.player)
				if (j != 0) return j
				else return o.score.compareTo(o.score)
			}
		} else {
			return -1
		}
	}
    
}
