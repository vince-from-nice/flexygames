package flexygames

import flexygames.admin.SubscriptionService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SubscriptionServiceSpec extends Specification {

    SubscriptionService subscriptionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Subscription(...).save(flush: true, failOnError: true)
        //new Subscription(...).save(flush: true, failOnError: true)
        //Subscription subscription = new Subscription(...).save(flush: true, failOnError: true)
        //new Subscription(...).save(flush: true, failOnError: true)
        //new Subscription(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //subscription.id
    }

    void "test get"() {
        setupData()

        expect:
        subscriptionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Subscription> subscriptionList = subscriptionService.list(max: 2, offset: 2)

        then:
        subscriptionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        subscriptionService.count() == 5
    }

    void "test delete"() {
        Long subscriptionId = setupData()

        expect:
        subscriptionService.count() == 5

        when:
        subscriptionService.delete(subscriptionId)
        sessionFactory.currentSession.flush()

        then:
        subscriptionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Subscription subscription = new Subscription()
        subscriptionService.save(subscription)

        then:
        subscription.id != null
    }
}
