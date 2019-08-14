package flexygames

import flexygames.admin.GameActionService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GameActionServiceSpec extends Specification {

    GameActionService gameActionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new GameAction(...).save(flush: true, failOnError: true)
        //new GameAction(...).save(flush: true, failOnError: true)
        //GameAction gameAction = new GameAction(...).save(flush: true, failOnError: true)
        //new GameAction(...).save(flush: true, failOnError: true)
        //new GameAction(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //gameAction.id
    }

    void "test get"() {
        setupData()

        expect:
        gameActionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<GameAction> gameActionList = gameActionService.list(max: 2, offset: 2)

        then:
        gameActionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        gameActionService.count() == 5
    }

    void "test delete"() {
        Long gameActionId = setupData()

        expect:
        gameActionService.count() == 5

        when:
        gameActionService.delete(gameActionId)
        sessionFactory.currentSession.flush()

        then:
        gameActionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        GameAction gameAction = new GameAction()
        gameActionService.save(gameAction)

        then:
        gameAction.id != null
    }
}
