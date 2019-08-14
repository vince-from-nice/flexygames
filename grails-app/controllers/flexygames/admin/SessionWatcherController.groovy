package flexygames.admin

import flexygames.SessionWatcher
import flexygames.admin.SessionWatcherService
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SessionWatcherController {

    SessionWatcherService sessionWatcherService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sessionWatcherService.list(params), model:[sessionWatcherCount: sessionWatcherService.count()]
    }

    def show(Long id) {
        respond sessionWatcherService.get(id)
    }

    def create() {
        respond new SessionWatcher(params)
    }

    def save(SessionWatcher sessionWatcher) {
        if (sessionWatcher == null) {
            notFound()
            return
        }

        try {
            sessionWatcherService.save(sessionWatcher)
        } catch (ValidationException e) {
            respond sessionWatcher.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionWatcher.label', default: 'SessionWatcher'), sessionWatcher.id])
                redirect sessionWatcher
            }
            '*' { respond sessionWatcher, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sessionWatcherService.get(id)
    }

    def update(SessionWatcher sessionWatcher) {
        if (sessionWatcher == null) {
            notFound()
            return
        }

        try {
            sessionWatcherService.save(sessionWatcher)
        } catch (ValidationException e) {
            respond sessionWatcher.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionWatcher.label', default: 'SessionWatcher'), sessionWatcher.id])
                redirect sessionWatcher
            }
            '*'{ respond sessionWatcher, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sessionWatcherService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionWatcher.label', default: 'SessionWatcher'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionWatcher.label', default: 'SessionWatcher'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
