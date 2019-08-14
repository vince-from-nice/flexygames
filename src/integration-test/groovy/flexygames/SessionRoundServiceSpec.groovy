package flexygames

import flexygames.admin.SessionRoundService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SessionRoundServiceSpec extends Specification {

    SessionRoundService sessionRoundService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SessionRound(...).save(flush: true, failOnError: true)
        //new SessionRound(...).save(flush: true, failOnError: true)
        //SessionRound sessionRound = new SessionRound(...).save(flush: true, failOnError: true)
        //new SessionRound(...).save(flush: true, failOnError: true)
        //new SessionRound(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sessionRound.id
    }

    void "test get"() {
        setupData()

        expect:
        sessionRoundService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SessionRound> sessionRoundList = sessionRoundService.list(max: 2, offset: 2)

        then:
        sessionRoundList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sessionRoundService.count() == 5
    }

    void "test delete"() {
        Long sessionRoundId = setupData()

        expect:
        sessionRoundService.count() == 5

        when:
        sessionRoundService.delete(sessionRoundId)
        sessionFactory.currentSession.flush()

        then:
        sessionRoundService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SessionRound sessionRound = new SessionRound()
        sessionRoundService.save(sessionRound)

        then:
        sessionRound.id != null
    }
}
