package flexygames

class Task implements Comparable<Task> {

    TaskType type

    static belongsTo = [session: Session, user: User]

    static constraints = {
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", type=" + type +
                ", session=" + session +
                ", user=" + user +
                '}';
    }

    @Override
    int compareTo(Task o) {
        int i = session.compareTo(o.session)
        if (i != 0) return i
        i = type.compareTo(o.type)
        if (i != 0) return i
        return user.compareTo(o.user)
    }
}
