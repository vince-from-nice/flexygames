package flexygames

class SessionWatcher {

    static belongsTo = [ session: Session, user: User ]

    static constraints = {
    }
}
