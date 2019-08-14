package flexygames

import flexygames.admin.GameSkillService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class GameSkillServiceSpec extends Specification {

    GameSkillService gameSkillService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new GameSkill(...).save(flush: true, failOnError: true)
        //new GameSkill(...).save(flush: true, failOnError: true)
        //GameSkill gameSkill = new GameSkill(...).save(flush: true, failOnError: true)
        //new GameSkill(...).save(flush: true, failOnError: true)
        //new GameSkill(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //gameSkill.id
    }

    void "test get"() {
        setupData()

        expect:
        gameSkillService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<GameSkill> gameSkillList = gameSkillService.list(max: 2, offset: 2)

        then:
        gameSkillList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        gameSkillService.count() == 5
    }

    void "test delete"() {
        Long gameSkillId = setupData()

        expect:
        gameSkillService.count() == 5

        when:
        gameSkillService.delete(gameSkillId)
        sessionFactory.currentSession.flush()

        then:
        gameSkillService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        GameSkill gameSkill = new GameSkill()
        gameSkillService.save(gameSkill)

        then:
        gameSkill.id != null
    }
}
