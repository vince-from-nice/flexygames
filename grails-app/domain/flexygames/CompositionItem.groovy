package flexygames

class CompositionItem implements Comparable<CompositionItem> {
	
	int x
	int y

    static constraints = {
    }
	
	static belongsTo = [composition: Composition, player: User]

	@Override
	public int compareTo(CompositionItem o) {
		if (o != null) {
			def i = composition.compareTo(o.composition)
			if (i != 0) {
				return i
			} else {
				return - player.compareTo(o.player)
			}
		} else {
			return -1
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CompositionItem other = (CompositionItem) obj;
		if (composition != obj.composition || player != obj.player) 
			return false;
		return true;
	}
	
	
	
}
