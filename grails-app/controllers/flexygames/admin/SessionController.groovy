package flexygames.admin

import flexygames.Session

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SessionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Session.list(params), model:[sessionInstanceCount: Session.count()]
    }

    def show(Session sessionInstance) {
        respond sessionInstance
    }

    def create() {
        respond new Session(params)
    }

    @Transactional
    def save(Session sessionInstance) {
        if (sessionInstance == null) {
            notFound()
            return
        }

        if (sessionInstance.hasErrors()) {
            respond sessionInstance.errors, view:'create'
            return
        }

        sessionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'session.label', default: 'Session'), sessionInstance.id])
                redirect sessionInstance
            }
            '*' { respond sessionInstance, [status: CREATED] }
        }
    }

    def edit(Session sessionInstance) {
        respond sessionInstance
    }

    @Transactional
    def update(Session sessionInstance) {
        if (sessionInstance == null) {
            notFound()
            return
        }

        if (sessionInstance.hasErrors()) {
            respond sessionInstance.errors, view:'edit'
            return
        }

        sessionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Session.label', default: 'Session'), sessionInstance.id])
                redirect sessionInstance
            }
            '*'{ respond sessionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Session sessionInstance) {

        if (sessionInstance == null) {
            notFound()
            return
        }

        sessionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Session.label', default: 'Session'), sessionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
