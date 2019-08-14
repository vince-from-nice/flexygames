package flexygames

import flexygames.admin.GameTypeService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GameTypeServiceSpec extends Specification {

    GameTypeService gameTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new GameType(...).save(flush: true, failOnError: true)
        //new GameType(...).save(flush: true, failOnError: true)
        //GameType gameType = new GameType(...).save(flush: true, failOnError: true)
        //new GameType(...).save(flush: true, failOnError: true)
        //new GameType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //gameType.id
    }

    void "test get"() {
        setupData()

        expect:
        gameTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<GameType> gameTypeList = gameTypeService.list(max: 2, offset: 2)

        then:
        gameTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        gameTypeService.count() == 5
    }

    void "test delete"() {
        Long gameTypeId = setupData()

        expect:
        gameTypeService.count() == 5

        when:
        gameTypeService.delete(gameTypeId)
        sessionFactory.currentSession.flush()

        then:
        gameTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        GameType gameType = new GameType()
        gameTypeService.save(gameType)

        then:
        gameType.id != null
    }
}
