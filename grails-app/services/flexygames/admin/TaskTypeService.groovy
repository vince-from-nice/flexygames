package flexygames.admin

import flexygames.TaskType
import grails.gorm.services.Service

@Service(TaskType)
interface TaskTypeService {

    TaskType get(Serializable id)

    List<TaskType> list(Map args)

    Long count()

    void delete(Serializable id)

    TaskType save(TaskType taskType)

}