package flexygames.admin

import flexygames.SessionWatcher
import grails.gorm.services.Service

@Service(SessionWatcher)
interface SessionWatcherService {

    SessionWatcher get(Serializable id)

    List<SessionWatcher> list(Map args)

    Long count()

    void delete(Serializable id)

    SessionWatcher save(SessionWatcher sessionWatcher)

}