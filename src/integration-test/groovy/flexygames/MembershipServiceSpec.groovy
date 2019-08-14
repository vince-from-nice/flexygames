package flexygames

import flexygames.admin.MembershipService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class MembershipServiceSpec extends Specification {

    MembershipService membershipService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Membership(...).save(flush: true, failOnError: true)
        //new Membership(...).save(flush: true, failOnError: true)
        //Membership membership = new Membership(...).save(flush: true, failOnError: true)
        //new Membership(...).save(flush: true, failOnError: true)
        //new Membership(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //membership.id
    }

    void "test get"() {
        setupData()

        expect:
        membershipService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Membership> membershipList = membershipService.list(max: 2, offset: 2)

        then:
        membershipList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        membershipService.count() == 5
    }

    void "test delete"() {
        Long membershipId = setupData()

        expect:
        membershipService.count() == 5

        when:
        membershipService.delete(membershipId)
        sessionFactory.currentSession.flush()

        then:
        membershipService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Membership membership = new Membership()
        membershipService.save(membership)

        then:
        membership.id != null
    }
}
