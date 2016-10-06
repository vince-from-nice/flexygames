package flexygames



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SessionGroupController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SessionGroup.list(params), model:[sessionGroupInstanceCount: SessionGroup.count()]
    }

    def show(SessionGroup sessionGroupInstance) {
        respond sessionGroupInstance
    }

    def create() {
        respond new SessionGroup(params)
    }

    @Transactional
    def save(SessionGroup sessionGroupInstance) {
        if (sessionGroupInstance == null) {
            notFound()
            return
        }

        if (sessionGroupInstance.hasErrors()) {
            respond sessionGroupInstance.errors, view:'create'
            return
        }

        sessionGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), sessionGroupInstance.id])
                redirect sessionGroupInstance
            }
            '*' { respond sessionGroupInstance, [status: CREATED] }
        }
    }

    def edit(SessionGroup sessionGroupInstance) {
        respond sessionGroupInstance
    }

    @Transactional
    def update(SessionGroup sessionGroupInstance) {
        if (sessionGroupInstance == null) {
            notFound()
            return
        }

        if (sessionGroupInstance.hasErrors()) {
            respond sessionGroupInstance.errors, view:'edit'
            return
        }

        sessionGroupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SessionGroup.label', default: 'SessionGroup'), sessionGroupInstance.id])
                redirect sessionGroupInstance
            }
            '*'{ respond sessionGroupInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SessionGroup sessionGroupInstance) {

        if (sessionGroupInstance == null) {
            notFound()
            return
        }

        sessionGroupInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SessionGroup.label', default: 'SessionGroup'), sessionGroupInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
