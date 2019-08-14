package flexygames

import flexygames.admin.PlaygroundService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PlaygroundServiceSpec extends Specification {

    PlaygroundService playgroundService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Playground(...).save(flush: true, failOnError: true)
        //new Playground(...).save(flush: true, failOnError: true)
        //Playground playground = new Playground(...).save(flush: true, failOnError: true)
        //new Playground(...).save(flush: true, failOnError: true)
        //new Playground(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //playground.id
    }

    void "test get"() {
        setupData()

        expect:
        playgroundService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Playground> playgroundList = playgroundService.list(max: 2, offset: 2)

        then:
        playgroundList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        playgroundService.count() == 5
    }

    void "test delete"() {
        Long playgroundId = setupData()

        expect:
        playgroundService.count() == 5

        when:
        playgroundService.delete(playgroundId)
        sessionFactory.currentSession.flush()

        then:
        playgroundService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Playground playground = new Playground()
        playgroundService.save(playground)

        then:
        playground.id != null
    }
}
