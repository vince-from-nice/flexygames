package flexygames.admin

import flexygames.SessionComment
import grails.gorm.services.Service

@Service(SessionComment)
interface SessionCommentService {

    SessionComment get(Serializable id)

    List<SessionComment> list(Map args)

    Long count()

    void delete(Serializable id)

    SessionComment save(SessionComment sessionComment)

}