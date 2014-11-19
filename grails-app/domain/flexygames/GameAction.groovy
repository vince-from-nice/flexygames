package flexygames

class GameAction  {

    User mainContributor
    
    User secondaryContributor
	
	Boolean forFirstTeamIfOrphelin // has sens if and only if the main contributor is unkown !
    
    static belongsTo = [sessionRound: SessionRound]
    
	static mapping = {
		version false
	}
	
    static constraints = {
        sessionRound(nullable: false)
        mainContributor(nullable: true)
        secondaryContributor(nullable: true)
		forFirstTeamIfOrphelin(nullable: true)
    }
	
//	public int compareTo (Object o) {
//		if (o instanceof GameAction) {
//			return sessionRound.session.compareTo(o.session.session)
//		}
//		else return -1
//	}
}
