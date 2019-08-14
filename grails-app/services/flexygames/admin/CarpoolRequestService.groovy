package flexygames.admin

import flexygames.CarpoolRequest
import grails.gorm.services.Service

@Service(CarpoolRequest)
interface CarpoolRequestService {

    CarpoolRequest get(Serializable id)

    List<CarpoolRequest> list(Map args)

    Long count()

    void delete(Serializable id)

    CarpoolRequest save(CarpoolRequest carpoolRequest)

}