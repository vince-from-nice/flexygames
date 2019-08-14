package flexygames.admin

import flexygames.GameAction
import grails.gorm.services.Service

@Service(GameAction)
interface GameActionService {

    GameAction get(Serializable id)

    List<GameAction> list(Map args)

    Long count()

    void delete(Serializable id)

    GameAction save(GameAction gameAction)

}