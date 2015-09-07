package flexygames

import java.util.Date;
import java.util.List;

class Composition implements Comparable<Composition> {
	
	//CompositionType type
	String description
	//Date creation
	//User creator
	Date lastUpdate
	User lastUpdater
	List<CompositionItem> items
	
    static constraints = {   
		description nullable:true, blank:true 
		lastUpdate nullable:false
		lastUpdater nullable:false
    }
	
	static belongsTo = [session: Session]
	
	static hasMany = [items: CompositionItem]
	@Override
	public int compareTo(Composition o) {
		if (o instanceof Composition && description != null) {
			return description.compareTo(o?.description)
		} else {
			return -1
		}
	}
}
