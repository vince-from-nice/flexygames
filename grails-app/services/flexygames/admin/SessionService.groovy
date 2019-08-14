package flexygames.admin

import flexygames.Session
import grails.gorm.services.Service

@Service(Session)
interface SessionService {

    Session get(Serializable id)

    List<Session> list(Map args)

    Long count()

    void delete(Serializable id)

    Session save(Session session)

}