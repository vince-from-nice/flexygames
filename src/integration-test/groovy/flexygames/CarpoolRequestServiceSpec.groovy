package flexygames

import flexygames.admin.CarpoolRequestService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CarpoolRequestServiceSpec extends Specification {

    CarpoolRequestService carpoolRequestService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CarpoolRequest(...).save(flush: true, failOnError: true)
        //new CarpoolRequest(...).save(flush: true, failOnError: true)
        //CarpoolRequest carpoolRequest = new CarpoolRequest(...).save(flush: true, failOnError: true)
        //new CarpoolRequest(...).save(flush: true, failOnError: true)
        //new CarpoolRequest(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //carpoolRequest.id
    }

    void "test get"() {
        setupData()

        expect:
        carpoolRequestService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CarpoolRequest> carpoolRequestList = carpoolRequestService.list(max: 2, offset: 2)

        then:
        carpoolRequestList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        carpoolRequestService.count() == 5
    }

    void "test delete"() {
        Long carpoolRequestId = setupData()

        expect:
        carpoolRequestService.count() == 5

        when:
        carpoolRequestService.delete(carpoolRequestId)
        sessionFactory.currentSession.flush()

        then:
        carpoolRequestService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CarpoolRequest carpoolRequest = new CarpoolRequest()
        carpoolRequestService.save(carpoolRequest)

        then:
        carpoolRequest.id != null
    }
}
