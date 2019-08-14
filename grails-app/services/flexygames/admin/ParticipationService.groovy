package flexygames.admin

import flexygames.Participation
import grails.gorm.services.Service

@Service(Participation)
interface ParticipationService {

    Participation get(Serializable id)

    List<Participation> list(Map args)

    Long count()

    void delete(Serializable id)

    Participation save(Participation participation)

}