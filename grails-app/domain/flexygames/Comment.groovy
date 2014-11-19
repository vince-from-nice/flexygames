package flexygames

class Comment implements Comparable<Comment> {
    
    Date date
    String text
    
    static belongsTo = [user: User, session: Session]
    
    static constraints = {
        user()
        session()
        date()
        text(blank:false, maxSize:10000)
    }
	
	int compareTo(Object o) {
		if (o instanceof Comment) {
			return - date.compareTo(o.date)
		} else {
			return false
		}
	}
}
