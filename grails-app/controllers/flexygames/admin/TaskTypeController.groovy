package flexygames.admin

import flexygames.TaskType

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class TaskTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TaskType.list(params), model:[taskTypeInstanceCount: TaskType.count()]
    }

    def show(TaskType taskTypeInstance) {
        respond taskTypeInstance
    }

    def create() {
        respond new TaskType(params)
    }

    @Transactional
    def save(TaskType taskTypeInstance) {
        if (taskTypeInstance == null) {
            notFound()
            return
        }

        if (taskTypeInstance.hasErrors()) {
            respond taskTypeInstance.errors, view:'create'
            return
        }

        taskTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'taskType.label', default: 'TaskType'), taskTypeInstance.id])
                redirect taskTypeInstance
            }
            '*' { respond taskTypeInstance, [status: CREATED] }
        }
    }

    def edit(TaskType taskTypeInstance) {
        respond taskTypeInstance
    }

    @Transactional
    def update(TaskType taskTypeInstance) {
        if (taskTypeInstance == null) {
            notFound()
            return
        }

        if (taskTypeInstance.hasErrors()) {
            respond taskTypeInstance.errors, view:'edit'
            return
        }

        taskTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TaskType.label', default: 'TaskType'), taskTypeInstance.id])
                redirect taskTypeInstance
            }
            '*'{ respond taskTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TaskType taskTypeInstance) {

        if (taskTypeInstance == null) {
            notFound()
            return
        }

        taskTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TaskType.label', default: 'TaskType'), taskTypeInstance.id])
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
