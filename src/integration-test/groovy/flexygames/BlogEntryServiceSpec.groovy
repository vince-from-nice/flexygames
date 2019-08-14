package flexygames

import flexygames.admin.BlogEntryService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class BlogEntryServiceSpec extends Specification {

    BlogEntryService blogEntryService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new BlogEntry(...).save(flush: true, failOnError: true)
        //new BlogEntry(...).save(flush: true, failOnError: true)
        //BlogEntry blogEntry = new BlogEntry(...).save(flush: true, failOnError: true)
        //new BlogEntry(...).save(flush: true, failOnError: true)
        //new BlogEntry(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //blogEntry.id
    }

    void "test get"() {
        setupData()

        expect:
        blogEntryService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<BlogEntry> blogEntryList = blogEntryService.list(max: 2, offset: 2)

        then:
        blogEntryList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        blogEntryService.count() == 5
    }

    void "test delete"() {
        Long blogEntryId = setupData()

        expect:
        blogEntryService.count() == 5

        when:
        blogEntryService.delete(blogEntryId)
        sessionFactory.currentSession.flush()

        then:
        blogEntryService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        BlogEntry blogEntry = new BlogEntry()
        blogEntryService.save(blogEntry)

        then:
        blogEntry.id != null
    }
}
