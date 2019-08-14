package flexygames

import flexygames.admin.TaskTypeService
import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class TaskTypeServiceSpec extends Specification {

    TaskTypeService taskTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new TaskType(...).save(flush: true, failOnError: true)
        //new TaskType(...).save(flush: true, failOnError: true)
        //TaskType taskType = new TaskType(...).save(flush: true, failOnError: true)
        //new TaskType(...).save(flush: true, failOnError: true)
        //new TaskType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //taskType.id
    }

    void "test get"() {
        setupData()

        expect:
        taskTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<TaskType> taskTypeList = taskTypeService.list(max: 2, offset: 2)

        then:
        taskTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        taskTypeService.count() == 5
    }

    void "test delete"() {
        Long taskTypeId = setupData()

        expect:
        taskTypeService.count() == 5

        when:
        taskTypeService.delete(taskTypeId)
        sessionFactory.currentSession.flush()

        then:
        taskTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        TaskType taskType = new TaskType()
        taskTypeService.save(taskType)

        then:
        taskType.id != null
    }
}
