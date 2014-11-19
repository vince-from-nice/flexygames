package flexygames

class Reminder implements Comparable<Reminder> {
	
	Integer minutesBeforeSession
	
	boolean jobExecuted = false
	
	static belongsTo = ['session' : Session]

    static constraints = {
		session()
		minutesBeforeSession(min: 0)
		jobExecuted()
    }
	
	int compareTo(Object o) {
		if (o instanceof Reminder) {
			return minutesBeforeSession.compareTo(o.minutesBeforeSession)
		} else {
			return false
		}
	}
}
