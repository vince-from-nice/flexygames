package flexygames

import flexygames.admin.SessionGroupService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SessionGroupServiceSpec extends Specification {

    SessionGroupService sessionGroupService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SessionGroup(...).save(flush: true, failOnError: true)
        //new SessionGroup(...).save(flush: true, failOnError: true)
        //SessionGroup sessionGroup = new SessionGroup(...).save(flush: true, failOnError: true)
        //new SessionGroup(...).save(flush: true, failOnError: true)
        //new SessionGroup(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sessionGroup.id
    }

    void "test get"() {
        setupData()

        expect:
        sessionGroupService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SessionGroup> sessionGroupList = sessionGroupService.list(max: 2, offset: 2)

        then:
        sessionGroupList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sessionGroupService.count() == 5
    }

    void "test delete"() {
        Long sessionGroupId = setupData()

        expect:
        sessionGroupService.count() == 5

        when:
        sessionGroupService.delete(sessionGroupId)
        sessionFactory.currentSession.flush()

        then:
        sessionGroupService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SessionGroup sessionGroup = new SessionGroup()
        sessionGroupService.save(sessionGroup)

        then:
        sessionGroup.id != null
    }
}
