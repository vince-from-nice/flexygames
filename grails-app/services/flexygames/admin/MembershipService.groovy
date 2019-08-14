package flexygames.admin

import flexygames.Membership
import grails.gorm.services.Service

@Service(Membership)
interface MembershipService {

    Membership get(Serializable id)

    List<Membership> list(Map args)

    Long count()

    void delete(Serializable id)

    Membership save(Membership membership)

}