package flexygames.admin

import flexygames.SessionRound
import grails.gorm.services.Service

@Service(SessionRound)
interface SessionRoundService {

    SessionRound get(Serializable id)

    List<SessionRound> list(Map args)

    Long count()

    void delete(Serializable id)

    SessionRound save(SessionRound sessionRound)

}