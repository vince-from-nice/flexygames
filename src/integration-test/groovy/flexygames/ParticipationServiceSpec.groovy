package flexygames

import flexygames.admin.ParticipationService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ParticipationServiceSpec extends Specification {

    ParticipationService participationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Participation(...).save(flush: true, failOnError: true)
        //new Participation(...).save(flush: true, failOnError: true)
        //Participation participation = new Participation(...).save(flush: true, failOnError: true)
        //new Participation(...).save(flush: true, failOnError: true)
        //new Participation(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //participation.id
    }

    void "test get"() {
        setupData()

        expect:
        participationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Participation> participationList = participationService.list(max: 2, offset: 2)

        then:
        participationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        participationService.count() == 5
    }

    void "test delete"() {
        Long participationId = setupData()

        expect:
        participationService.count() == 5

        when:
        participationService.delete(participationId)
        sessionFactory.currentSession.flush()

        then:
        participationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Participation participation = new Participation()
        participationService.save(participation)

        then:
        participation.id != null
    }
}
