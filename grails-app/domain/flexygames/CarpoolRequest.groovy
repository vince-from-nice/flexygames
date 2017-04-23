package flexygames

class CarpoolRequest implements Comparable<flexygames.CarpoolRequest>{

    Session session
    User enquirer
    CarpoolProposal driver
    String pickupTime
    String pickupLocation
    String pickupTimeRange

    static belongsTo = [session: Session, enquirer: User]

    static constraints = {
        enquirer nullable: false, unique: 'session'
        driver nullable: true
        pickupLocation nullable: true, blank: true, maxSize: 30
        pickupTimeRange nullable: true, blank: true, maxSize: 20
        pickupTime nullable: true, blank: true, maxSize: 10
    }

    int compareTo(CarpoolRequest o) {
        return enquirer.username.compareTo(o.enquirer.username)
    }
}
