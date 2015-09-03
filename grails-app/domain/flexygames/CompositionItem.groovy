package flexygames

class CompositionItem {
	
	int x
	int y

    static constraints = {
    }
	
	static belongsTo = [composition: Composition, player: User]
}
