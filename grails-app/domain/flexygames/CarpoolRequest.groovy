package flexygames

class CarpoolRequest implements Comparable<flexygames.CarpoolRequest>{

    Session session
    User enquirer
    CarpoolProposal driver

    static belongsTo = [session: Session]

    static constraints = {
        enquirer nullable: false, unique: 'session'
        driver nullable: true
    }

    int compareTo(CarpoolRequest o) {
        return enquirer.username.compareTo(o.enquirer.username)
    }
}
