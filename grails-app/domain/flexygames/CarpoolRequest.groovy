package flexygames

class CarpoolRequest {

    Session session
    User enquirer
    CarpoolProposal driver

    static belongsTo = [session: Session]

    static constraints = {
        enquirer nullable: false, unique: 'session'
        driver nullable: true
    }
}
