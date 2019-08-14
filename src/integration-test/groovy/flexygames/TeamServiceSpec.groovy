package flexygames

import flexygames.admin.TeamService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class TeamServiceSpec extends Specification {

    TeamService teamService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Team(...).save(flush: true, failOnError: true)
        //new Team(...).save(flush: true, failOnError: true)
        //Team team = new Team(...).save(flush: true, failOnError: true)
        //new Team(...).save(flush: true, failOnError: true)
        //new Team(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //team.id
    }

    void "test get"() {
        setupData()

        expect:
        teamService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Team> teamList = teamService.list(max: 2, offset: 2)

        then:
        teamList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        teamService.count() == 5
    }

    void "test delete"() {
        Long teamId = setupData()

        expect:
        teamService.count() == 5

        when:
        teamService.delete(teamId)
        sessionFactory.currentSession.flush()

        then:
        teamService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Team team = new Team()
        teamService.save(team)

        then:
        team.id != null
    }
}
