package flexygames

class Task {

    TaskType type

    static belongsTo = [session: Session, user: User]

    static constraints = {
    }
}
