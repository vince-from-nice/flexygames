package flexygames.admin

import flexygames.GameSkill
import grails.gorm.services.Service

@Service(GameSkill)
interface GameSkillService {

    GameSkill get(Serializable id)

    List<GameSkill> list(Map args)

    Long count()

    void delete(Serializable id)

    GameSkill save(GameSkill gameSkill)

}