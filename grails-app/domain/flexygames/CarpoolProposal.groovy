package flexygames

class CarpoolProposal implements Comparable<CarpoolProposal> {

    Integer freePlaceNbr
    String carDescription
    String rdvDescription
    Session session
    User driver
    SortedSet<CarpoolRequest>  approvedRequests

    static belongsTo = [session: Session]

    static hasMany = [approvedRequests: CarpoolRequest]

    static constraints = {
        driver nullable: false, unique: 'session'
        freePlaceNbr min: 1, max: 9
        carDescription nullable: false, maxSize: 30
        rdvDescription nullable: true, maxSize: 100
    }

    int compareTo(CarpoolProposal o) {
        return driver.username.compareTo(o.driver.username)
    }
}
