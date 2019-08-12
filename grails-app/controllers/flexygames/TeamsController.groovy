package flexygames

import org.apache.shiro.SecurityUtils

class TeamsController {

	def statsService

	def forumService
	
	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list = {
		// prepare default params values
		params.max = Math.min(params.max ? params.int('max') : 10, 30)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "name"
		if(!params.order) params.order = "asc"
		def teams = Team.list(params)
		def teamsNbr = Team.count()
		[teamInstanceList: teams, teamInstanceTotal: teamsNbr]
	}

	def show = {
		def team = Team.get(params.id)
		if (!team) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team'), params.id])}"
			return redirect(action: "list")
		}
		if (!params.mode) {
			/*if (team.getAllSubscribedSessionGroups(true).size() > 0) {
				params.mode = "competition"
			} else {
				params.mode = "training"
			}*/
			params.mode = "blog"
		}
		if (params.mode == "blog") {
			showBlog(params, team)
		}
		else if (params.mode == "ranking") {
			showRanking(params, team)
		} else {
			[teamInstance: team]
		}
	}
	def showRanking(params, Team team) {
		def criteria = (params.criteria ? params.criteria : 'statuses.doneGood')
		def sessionGroupId = (params.sessionGroupId ? Integer.parseInt(params.sessionGroupId) : 0)
		SessionGroup sessionGroup = (sessionGroupId > 0 ? SessionGroup.get(sessionGroupId) : null)
		def membersRanking = statsService.getTeamMembersRanking(team, criteria, sessionGroup)
		return [teamInstance: team, membersRanking: membersRanking, currentCriteria: criteria, currentSessionGroupId: sessionGroupId]
	}
	
	def showBlog(params, Team team) {
		params.teamId = team.id
		params.max = Math.min(params.max ? params.int('max') : 5, 30)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "date"
		if(!params.order) params.order = "desc"
		// Get blog entries for all users of the team which are sticky
		def stickyUserBlogEntries = team.getBlogEntries([sort: 'date', order: 'desc'], true)
		// Get blog entries for all users of the team which are not sticky
		def normalUserBlogEntries = team.getBlogEntries(params, false)
		// Get next sessions
		def nextTraining = team.getNextSession(false)
		def nextCompetition = team.getNextSession(true)
		return [teamInstance: team, nextTraining: nextTraining, nextCompetition: nextCompetition, normalBlogEntriesTotal: team.countBlogEntries(false), normalUserBlogEntries: normalUserBlogEntries,
				stickyUserBlogEntries: stickyUserBlogEntries, params: params]
	}

	def displayBlogEntry = {
		BlogEntry be = BlogEntry.get(params.id)
		if (!be) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'blogEntry'), params.id])}"
			return redirect(action: "list")
		}
		render(view: 'blogEntry', model: ['blogEntry': be])
	}

	def postBlogComment = {
		BlogEntry be = BlogEntry.get(params.id)
		if (!be) {
			flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'blogEntry'), params.id])}"
			return redirect(action: "list")
		}
		def user = request.currentUser
		def comment
		try {
			comment = forumService.postBlogComment(user, be, params.comment)
			flash.message = "Ok comment has been posted !!"
		} catch (Exception e) {
			e.printStackTrace()
			flash.error = "${message(code: 'team.show.blog.comments.update.error', args: [e.message])}"
			return redirect(action: "displayBlogEntry", id: be.id)
		}
		redirect(action: "displayBlogEntry", id: be.id, fragment: "comment" + comment.id)
	}
}
