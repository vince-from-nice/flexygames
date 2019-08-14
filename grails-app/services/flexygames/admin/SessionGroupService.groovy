package flexygames.admin

import flexygames.SessionGroup
import grails.gorm.services.Service

@Service(SessionGroup)
interface SessionGroupService {

    SessionGroup get(Serializable id)

    List<SessionGroup> list(Map args)

    Long count()

    void delete(Serializable id)

    SessionGroup save(SessionGroup sessionGroup)

}