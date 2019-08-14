package flexygames.admin

import flexygames.Vote
import grails.gorm.services.Service

@Service(Vote)
interface VoteService {

    Vote get(Serializable id)

    List<Vote> list(Map args)

    Long count()

    void delete(Serializable id)

    Vote save(Vote vote)

}