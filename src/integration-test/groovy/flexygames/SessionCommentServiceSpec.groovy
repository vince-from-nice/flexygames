package flexygames

import flexygames.admin.SessionCommentService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SessionCommentServiceSpec extends Specification {

    SessionCommentService sessionCommentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SessionComment(...).save(flush: true, failOnError: true)
        //new SessionComment(...).save(flush: true, failOnError: true)
        //SessionComment sessionComment = new SessionComment(...).save(flush: true, failOnError: true)
        //new SessionComment(...).save(flush: true, failOnError: true)
        //new SessionComment(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sessionComment.id
    }

    void "test get"() {
        setupData()

        expect:
        sessionCommentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SessionComment> sessionCommentList = sessionCommentService.list(max: 2, offset: 2)

        then:
        sessionCommentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sessionCommentService.count() == 5
    }

    void "test delete"() {
        Long sessionCommentId = setupData()

        expect:
        sessionCommentService.count() == 5

        when:
        sessionCommentService.delete(sessionCommentId)
        sessionFactory.currentSession.flush()

        then:
        sessionCommentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SessionComment sessionComment = new SessionComment()
        sessionCommentService.save(sessionComment)

        then:
        sessionComment.id != null
    }
}
