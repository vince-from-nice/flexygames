package flexygames.admin

import flexygames.SessionGroup
import org.apache.shiro.SecurityUtils

import flexygames.User

import java.util.regex.Pattern;

class AdminController {

    def index = {        
    }

	def  refreshPlayerCounters = {
		for (User user in User.getAll()) {
			user.countParticipations()
			user.countAbsences()
			user.countGateCrashes()
			user.countComments()
		}
		flash.message = "Ok, counters has been refreshed for all players !"
		return redirect(controller: 'admin', action: 'index')
	}
	
	def findPlayer = {
		def t = '%' + params.playerToken + '%'
		def users = User.findAllByUsernameIlikeOrFirstNameIlikeOrLastNameIlikeOrEmailIlike(t, t, t, t)
		render (view: "index", model: [users: users, message: "" + users.size() + " user(s) has been found."])
	}

	def duplicateSessionGroup = {
		def group = SessionGroup.get(params.sessionGroupId)
		if (!group) {
			flash.error = "Unable to find session group with id=" + params.sessionGroupId
			return redirect(controller: 'admin', action: 'index')
		}
		def newName = duplicateNameToNextYear(group.name)
		if (!newName) {
			flash.error = "Unable to increment the years token in the name"
			return redirect(controller: 'admin', action: 'index')
		}
		if (SessionGroup.findByName(newName)) {
			flash.error = "A session group already exists for the next year !"
			return redirect(controller: 'admin', action: 'index')
		}
		def newGroup = new SessionGroup(name: newName, competition: group.competition, visible: group.visible,
				defaultType: group.defaultType, defaultPlayground: group.defaultPlayground, defaultDuration: group.defaultDuration,
				defaultMinPlayerNbr: group.defaultMinPlayerNbr, defaultMaxPlayerNbr: group.defaultMaxPlayerNbr, defaultPreferredPlayerNbr: group.defaultPreferredPlayerNbr,
				defaultLockingTime: group.defaultLockingTime, defaultDayOfWeek: group.defaultDayOfWeek,
				ballsTaskNeeded: group.ballsTaskNeeded, jerseyTaskNeeded: group.jerseyTaskNeeded)
		if (!newGroup.save()) {
			flash.error = "Unable to save duplicated session group: " + newGroup.errors
		} else {
			flash.message = "Session group <b>" + newGroup.name + "</b> has been saved !"
		}
		return redirect(controller: 'admin', action: 'index')
	}

	private String duplicateNameToNextYear(String name) {
		def result = null
		def SIMPLE_YEAR_TOKEN = '[0-9]{4}'
		def simpleYearMatcher = Pattern.compile(SIMPLE_YEAR_TOKEN).matcher(name)
		def DOUBLE_YEAR_TOKEN = '[0-9]{4}/[0-9]{4}'
		def doubleYearMatcher = Pattern.compile(DOUBLE_YEAR_TOKEN).matcher(name)
		if (doubleYearMatcher.find()) {
			int index = doubleYearMatcher.start()
			String yearz = name.substring(index, index + 9)
			String[] years = yearz.split('/')
			int firstYear = Integer.parseInt(years[0]) + 1
			int secondYear = Integer.parseInt(years[1]) + 1
			String newYears = "" + firstYear + "/" + secondYear
			result = name.replaceAll(DOUBLE_YEAR_TOKEN, newYears)
		} else if (simpleYearMatcher.find()) {
			int index = simpleYearMatcher.start()
			int year = Integer.parseInt(name.substring(index, index + 4)) + 1
			result = name.replaceAll(SIMPLE_YEAR_TOKEN, "" + year)
		}
		return result
	}
}
