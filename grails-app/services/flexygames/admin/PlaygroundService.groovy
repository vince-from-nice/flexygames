package flexygames.admin

import flexygames.Playground
import grails.gorm.services.Service

@Service(Playground)
interface PlaygroundService {

    Playground get(Serializable id)

    List<Playground> list(Map args)

    Long count()

    void delete(Serializable id)

    Playground save(Playground playground)

}