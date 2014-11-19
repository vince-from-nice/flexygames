package flexygames

import java.text.SimpleDateFormat


class SessionReminderJob {
	
    //def timeout = 5000l // execute job once in 5 seconds
	
	def reminderService 
	
	static triggers = {
		simple name:'simpleTrigger', startDelay:1, repeatInterval: 600000, repeatCount: -1
    }

    def execute() {
        println new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " FlexyGames : SessionReminderJob is triggering !!"
		reminderService.remindParticipants()
    }
}
