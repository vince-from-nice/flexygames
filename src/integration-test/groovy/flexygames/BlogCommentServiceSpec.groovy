package flexygames

import flexygames.admin.BlogCommentService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class BlogCommentServiceSpec extends Specification {

    BlogCommentService blogCommentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new BlogComment(...).save(flush: true, failOnError: true)
        //new BlogComment(...).save(flush: true, failOnError: true)
        //BlogComment blogComment = new BlogComment(...).save(flush: true, failOnError: true)
        //new BlogComment(...).save(flush: true, failOnError: true)
        //new BlogComment(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //blogComment.id
    }

    void "test get"() {
        setupData()

        expect:
        blogCommentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<BlogComment> blogCommentList = blogCommentService.list(max: 2, offset: 2)

        then:
        blogCommentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        blogCommentService.count() == 5
    }

    void "test delete"() {
        Long blogCommentId = setupData()

        expect:
        blogCommentService.count() == 5

        when:
        blogCommentService.delete(blogCommentId)
        sessionFactory.currentSession.flush()

        then:
        blogCommentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        BlogComment blogComment = new BlogComment()
        blogCommentService.save(blogComment)

        then:
        blogComment.id != null
    }
}
