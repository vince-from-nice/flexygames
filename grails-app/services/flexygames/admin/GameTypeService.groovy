package flexygames.admin

import flexygames.GameType
import grails.gorm.services.Service

@Service(GameType)
interface GameTypeService {

    GameType get(Serializable id)

    List<GameType> list(Map args)

    Long count()

    void delete(Serializable id)

    GameType save(GameType gameType)

}