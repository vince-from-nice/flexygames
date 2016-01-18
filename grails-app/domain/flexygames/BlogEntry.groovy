package flexygames

class BlogEntry implements Comparable {

    Date date
    String title
    String body
    Session session // transient field for automatic blog entries related to sessions

    static belongsTo = [user: User, team:Team]

    static transients = ['session']

    static constraints = {
        date(nullable:false)
        title(blank:false, maxSize:100)
        body(blank:false, maxSize:10000)
        session(nullable:true)
    }

    int compareTo(Object o) {
        if (o instanceof BlogEntry) {
            return - date.compareTo(o.date)
        } else {
            return false
        }
    }
}

