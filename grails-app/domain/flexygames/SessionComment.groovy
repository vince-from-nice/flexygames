package flexygames

class SessionComment implements Comparable<SessionComment> {
    
    Date date
    String text
    
    static belongsTo = [user: User, session: Session]
    
    static constraints = {
        user()
        session()
        date()
        text(blank:false, maxSize:10000)
    }

    @Override
    int compareTo(SessionComment o) {
        return - date.compareTo(o.date)
    }
}
