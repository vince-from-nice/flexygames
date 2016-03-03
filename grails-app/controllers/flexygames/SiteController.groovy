package flexygames

class SiteController {
	
	def mailerService
	
	static int STATS_TEAMS_SIZE = 10
	static int STATS_SESSIONS_GROUPS_SIZE = 10
	static int STATS_PARTICIPANTS_SIZE = 10
	static int STATS_POSTERS_SIZE = 20
	static int STATS_SCORERS_SIZE = 20
	
    def home = {
		def users = User.list(sort: 'registrationDate', order:'desc', max: 3)
		def sessions = Session.findAllByDateBetween(new Date() - 2, new Date() + 6, [sort: 'date', order:'asc'])
        render (view: "home", model: [users: users, sessions: sessions])
    }
    
    def about = {
        render (view: "about")
    }
	
	def features = {
		render (view: "features")
	}
	
	def tutorial = {
		render (view: "tutorial")
	}
	
	def contact = { command.ContactCommand cmd ->
		if (!request.post) {
			return render (view: "contact", )
		}
		if (cmd.hasErrors()) {
			//flash.message = "Unable to send message !"
			return render (view: "contact", model: [contactForm: cmd])
		}
		mailerService.mailForContact(cmd.email, cmd.subject, cmd.body)
		flash.message = 'Your message has been sent !'
		redirect(action: 'home')
	}
	
	def stats = {
		//def teams = "[ ['ASAS Football Team', 18], ['ASAS Volleyball Team', 4] ]"
		//def scorers = "[ [ 'turman', 23 ], [ 'ypos', 12 ], [ 'dudak', 40 ]]"
		
		// TODO THIS IS COMPLETELY UNOPTIMIZED ! :D
		// need to use JSON writer and an optimized SQL query (with aggregate counting)
	
		StringBuffer teams = new StringBuffer("[")
		def allTeams = Team.getAll().sort{ it.memberships.size()}.reverse()
		def max = (allTeams.size() <  STATS_TEAMS_SIZE ? allTeams.size() : STATS_TEAMS_SIZE)
		for (int i = 0; i < max; i++) {
			def team = allTeams.get(i)
			teams.append("['" + team.name + "', " + team.memberships.size() + "]")
			if (i < max - 1) teams.append(", ")
		}
		teams.append("]")
		
		StringBuffer groups = new StringBuffer("[")
		def allGroups = SessionGroup.getAll().sort{ it.sessions.size()}.reverse()
		max = (allGroups.size() <  STATS_SESSIONS_GROUPS_SIZE ? allGroups.size() : STATS_SESSIONS_GROUPS_SIZE)
		for (int i = 0; i < max; i++) {
			def group = allGroups.get(i)
			groups.append("['" + group.name.replaceAll("'", "\\\\'") + "', " + group.sessions.size() + "]")
			if (i < max - 1) groups.append(", ")
		}
		groups.append("]")
		
		StringBuffer participants = new StringBuffer("[")
		def allParticipants = User.getAll().sort{ it.countParticipations()}.reverse()
		max = (allParticipants.size() <  STATS_SCORERS_SIZE ? allParticipants.size() : STATS_SCORERS_SIZE)
		for (int i = 0; i < max; i++) {
			def user = allParticipants.get(i)
			participants.append("['" + user.username + "', " + user.countParticipations() /*+ ", " + user.id*/ + "]")
			if (i < max - 1) participants.append(", ")
		}
		participants.append("]")
		
		StringBuffer posters = new StringBuffer("[")
		def allPosters = User.getAll().sort{ it.countComments()}.reverse()
		max = (allPosters.size() <  STATS_SCORERS_SIZE ? allPosters.size() : STATS_SCORERS_SIZE)
		for (int i = 0; i < max; i++) {
			def user = allPosters.get(i)
			posters.append("['" + user.username + "', " + user.countComments() + "]")
			if (i < max - 1) posters.append(", ")
		}
		posters.append("]")
		
//		StringBuffer scorers = new StringBuffer("[")
//		def allScorers = User.getAll().sort{ it.actions.size()}.reverse()
//		max = (allScorers.size() <  STATS_SCORERS_SIZE ? allScorers.size() : STATS_SCORERS_SIZE)
//		for (int i = 0; i < max; i++) {
//			def user = allScorers.get(i)
//			def score = 0
//			user.actions.each{score++}
//			scorers.append("['" + user.username + "', " + score + "]")
//			if (i < max - 1) scorers.append(", ")
//		}
//		scorers.append("]")
		
		render (view: "stats", model: ['teams': teams, 'groups' : groups, 'participants': participants, 'posters': posters])
	}
}
