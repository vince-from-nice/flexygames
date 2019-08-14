package flexygames

import flexygames.admin.SessionWatcherService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SessionWatcherServiceSpec extends Specification {

    SessionWatcherService sessionWatcherService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SessionWatcher(...).save(flush: true, failOnError: true)
        //new SessionWatcher(...).save(flush: true, failOnError: true)
        //SessionWatcher sessionWatcher = new SessionWatcher(...).save(flush: true, failOnError: true)
        //new SessionWatcher(...).save(flush: true, failOnError: true)
        //new SessionWatcher(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sessionWatcher.id
    }

    void "test get"() {
        setupData()

        expect:
        sessionWatcherService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SessionWatcher> sessionWatcherList = sessionWatcherService.list(max: 2, offset: 2)

        then:
        sessionWatcherList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sessionWatcherService.count() == 5
    }

    void "test delete"() {
        Long sessionWatcherId = setupData()

        expect:
        sessionWatcherService.count() == 5

        when:
        sessionWatcherService.delete(sessionWatcherId)
        sessionFactory.currentSession.flush()

        then:
        sessionWatcherService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SessionWatcher sessionWatcher = new SessionWatcher()
        sessionWatcherService.save(sessionWatcher)

        then:
        sessionWatcher.id != null
    }
}
