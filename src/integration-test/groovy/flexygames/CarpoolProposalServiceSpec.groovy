package flexygames

import flexygames.admin.CarpoolProposalService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CarpoolProposalServiceSpec extends Specification {

    CarpoolProposalService carpoolProposalService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CarpoolProposal(...).save(flush: true, failOnError: true)
        //new CarpoolProposal(...).save(flush: true, failOnError: true)
        //CarpoolProposal carpoolProposal = new CarpoolProposal(...).save(flush: true, failOnError: true)
        //new CarpoolProposal(...).save(flush: true, failOnError: true)
        //new CarpoolProposal(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //carpoolProposal.id
    }

    void "test get"() {
        setupData()

        expect:
        carpoolProposalService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CarpoolProposal> carpoolProposalList = carpoolProposalService.list(max: 2, offset: 2)

        then:
        carpoolProposalList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        carpoolProposalService.count() == 5
    }

    void "test delete"() {
        Long carpoolProposalId = setupData()

        expect:
        carpoolProposalService.count() == 5

        when:
        carpoolProposalService.delete(carpoolProposalId)
        sessionFactory.currentSession.flush()

        then:
        carpoolProposalService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CarpoolProposal carpoolProposal = new CarpoolProposal()
        carpoolProposalService.save(carpoolProposal)

        then:
        carpoolProposal.id != null
    }
}
