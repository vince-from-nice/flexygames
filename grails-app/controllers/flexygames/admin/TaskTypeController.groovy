package flexygames.admin

import flexygames.TaskType
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class TaskTypeController {

    static namespace = 'admin'

    TaskTypeService taskTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond taskTypeService.list(params), model:[taskTypeCount: taskTypeService.count()]
    }

    def show(Long id) {
        respond taskTypeService.get(id)
    }

    def create() {
        respond new TaskType(params)
    }

    def save(TaskType taskType) {
        if (taskType == null) {
            notFound()
            return
        }

        try {
            taskTypeService.save(taskType)
        } catch (ValidationException e) {
            respond taskType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'taskType.label', default: 'TaskType'), taskType.id])
                redirect taskType
            }
            '*' { respond taskType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond taskTypeService.get(id)
    }

    def update(TaskType taskType) {
        if (taskType == null) {
            notFound()
            return
        }

        try {
            taskTypeService.save(taskType)
        } catch (ValidationException e) {
            respond taskType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'taskType.label', default: 'TaskType'), taskType.id])
                redirect taskType
            }
            '*'{ respond taskType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        taskTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'taskType.label', default: 'TaskType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'taskType.label', default: 'TaskType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
