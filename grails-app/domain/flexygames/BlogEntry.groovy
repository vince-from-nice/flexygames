package flexygames

class BlogEntry implements Comparable {

    Date date
    Date lastUpdate
    User lastUpdater
    String title
    String body
    Session session // transient field for automatic blog entries related to sessions

    static belongsTo = [user: User, team:Team]

    static transients = ['session']

    static constraints = {
        date(nullable: false)
        title(blank: false, maxSize: 64)
        body(blank: false, maxSize: 10000)
        team(nullable: false)
        user(nullable: false)
        session(nullable: true)
        lastUpdate(nullable: true)
        lastUpdater(nullable: true)
    }

    int compareTo(Object o) {
        if (o instanceof BlogEntry) {
            return - date.compareTo(o.date)
        } else {
            return false
        }
    }
}

