package flexygames.admin

import flexygames.CarpoolProposal
import grails.gorm.services.Service

@Service(CarpoolProposal)
interface CarpoolProposalService {

    CarpoolProposal get(Serializable id)

    List<CarpoolProposal> list(Map args)

    Long count()

    void delete(Serializable id)

    CarpoolProposal save(CarpoolProposal carpoolProposal)

}