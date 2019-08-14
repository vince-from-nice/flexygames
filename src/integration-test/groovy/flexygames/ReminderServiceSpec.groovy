package flexygames

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ReminderServiceSpec extends Specification {

    ReminderService reminderService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Reminder(...).save(flush: true, failOnError: true)
        //new Reminder(...).save(flush: true, failOnError: true)
        //Reminder reminder = new Reminder(...).save(flush: true, failOnError: true)
        //new Reminder(...).save(flush: true, failOnError: true)
        //new Reminder(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //reminder.id
    }

    void "test get"() {
        setupData()

        expect:
        reminderService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Reminder> reminderList = reminderService.list(max: 2, offset: 2)

        then:
        reminderList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        reminderService.count() == 5
    }

    void "test delete"() {
        Long reminderId = setupData()

        expect:
        reminderService.count() == 5

        when:
        reminderService.delete(reminderId)
        sessionFactory.currentSession.flush()

        then:
        reminderService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Reminder reminder = new Reminder()
        reminderService.save(reminder)

        then:
        reminder.id != null
    }
}
