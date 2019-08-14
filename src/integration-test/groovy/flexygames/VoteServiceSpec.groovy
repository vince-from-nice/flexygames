package flexygames

import flexygames.admin.VoteService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class VoteServiceSpec extends Specification {

    VoteService voteService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Vote(...).save(flush: true, failOnError: true)
        //new Vote(...).save(flush: true, failOnError: true)
        //Vote vote = new Vote(...).save(flush: true, failOnError: true)
        //new Vote(...).save(flush: true, failOnError: true)
        //new Vote(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //vote.id
    }

    void "test get"() {
        setupData()

        expect:
        voteService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Vote> voteList = voteService.list(max: 2, offset: 2)

        then:
        voteList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        voteService.count() == 5
    }

    void "test delete"() {
        Long voteId = setupData()

        expect:
        voteService.count() == 5

        when:
        voteService.delete(voteId)
        sessionFactory.currentSession.flush()

        then:
        voteService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Vote vote = new Vote()
        voteService.save(vote)

        then:
        vote.id != null
    }
}
