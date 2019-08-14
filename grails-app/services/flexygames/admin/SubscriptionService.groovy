package flexygames.admin

import flexygames.Subscription
import grails.gorm.services.Service

@Service(Subscription)
interface SubscriptionService {

    Subscription get(Serializable id)

    List<Subscription> list(Map args)

    Long count()

    void delete(Serializable id)

    Subscription save(Subscription subscription)

}