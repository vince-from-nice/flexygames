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
		render(view: 'home', model: [users: users, sessions: sessions])
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
	
	def contact = { flexygames.command.ContactCommand cmd ->
		if (!request.post) {
			return render (view: "contact", )
		}
		if (cmd.hasErrors()) {
			//flash.message = "Unable to send message !"
			return render (view: "contact", model: [contactForm: cmd])
		}
		if (cmd.botChalenge != "21") {
			flash.error = "Sorry Mr Bot, your response to the chalenge is incorrect :)"
			return render (view: "contact", model: [contactForm: cmd])
		}
		mailerService.mailForContact(cmd.email, cmd.subject, cmd.body)
		flash.message = 'Your message has been sent !'
		redirect(action: 'home')
	}
	
	def stats = {
		def users = User.getAll()
		def teams = top(Team.getAll(), STATS_TEAMS_SIZE) { it.memberships.size() }
				.collect { [label: it.key.name, value: it.value, link: [controller: 'teams', action: 'show', id: it.key.id]] }
		def groups = top(SessionGroup.getAll(), STATS_SESSIONS_GROUPS_SIZE) { it.sessions.size() }
				.collect { [label: it.key.name, value: it.value, link: [controller: 'sessions', action: 'list', params: [filteredSessionGroup: it.key.id]]] }
		def participants = top(users, STATS_SCORERS_SIZE) { it.participationCounter }
				.collect { [label: it.key.username, value: it.value, link: [controller: 'player', action: 'show', id: it.key.id]] }
		def posters = top(users, STATS_SCORERS_SIZE) { it.commentCounter }
				.collect { [label: it.key.username, value: it.value, link: [controller: 'player', action: 'show', id: it.key.id]] }
		render (view: "stats", model: ['teams': teams, 'groups' : groups, 'participants': participants, 'posters': posters])
	}

	/** The items with the highest positive values, highest first, as entries item -> value. */
	private static List<Map.Entry> top(Collection items, int size, Closure<Number> valueOf) {
		items.collectEntries { [(it): valueOf(it) ?: 0] }
				.findAll { it.value > 0 }
				.sort { -it.value }
				.take(size)
				.collect()
	}
}
