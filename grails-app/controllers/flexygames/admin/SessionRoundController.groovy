package flexygames.admin

import flexygames.SessionRound
import flexygames.admin.SessionRoundService
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SessionRoundController {

    static namespace = 'admin'

    SessionRoundService sessionRoundService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sessionRoundService.list(params), model:[sessionRoundCount: sessionRoundService.count()]
    }

    def show(Long id) {
        respond sessionRoundService.get(id)
    }

    def create() {
        respond new SessionRound(params)
    }

    def save(SessionRound sessionRound) {
        if (sessionRound == null) {
            notFound()
            return
        }

        try {
            sessionRoundService.save(sessionRound)
        } catch (ValidationException e) {
            respond sessionRound.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), sessionRound.id])
                redirect sessionRound
            }
            '*' { respond sessionRound, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sessionRoundService.get(id)
    }

    def update(SessionRound sessionRound) {
        if (sessionRound == null) {
            notFound()
            return
        }

        try {
            sessionRoundService.save(sessionRound)
        } catch (ValidationException e) {
            respond sessionRound.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), sessionRound.id])
                redirect sessionRound
            }
            '*'{ respond sessionRound, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sessionRoundService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
