package flexygames

import java.util.Date;
import java.util.List;
import java.util.Set;

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
	
	List<CompositionItem> getAllPlayersIncludingEligibleNotYetPresent() {
		List<CompositionItem> result = new ArrayList();
		// First add existing items
		result.addAll(items)
		// Then create transient items for eligible players who are not yet into the composition
		session.participantsEligibleForComposition.each { player ->
			if (!items.find{ it.player == player }) {
				result.add(new CompositionItem(player: player, composition: this, x: 0, y: 0))
			}
		}
		return result;
	}
	@Override
	public int compareTo(Composition o) {
		if (o != null && description != null && o.description != null) {
			def i = description.compareTo(o.description)
			if (i != 0) {
				return i
			} else {
				return - lastUpdate.compareTo(o.lastUpdate)
			}
		} else {
			return -1
		}
	}
}
