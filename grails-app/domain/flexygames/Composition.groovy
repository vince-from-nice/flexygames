package flexygames

import java.util.Date;

class Composition implements Comparable<Composition> {
	
	Session session
	String description
	Date creation
	User creator
	Date lastUpdate
	User lastUpdater
	
    static constraints = {
    }
	
	static belongsTo = [session: Session]
	@Override
	public int compareTo(Composition o) {
		return description.compareTo(o.description)
	}
}
