package flexygames.admin

import flexygames.SessionGroup
import flexygames.admin.SessionGroupService
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SessionGroupController {

    static namespace = 'admin'

    SessionGroupService sessionGroupService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sessionGroupService.list(params), model:[sessionGroupCount: sessionGroupService.count()]
    }

    def show(Long id) {
        respond sessionGroupService.get(id)
    }

    def create() {
        respond new SessionGroup(params)
    }

    def save(SessionGroup sessionGroup) {
        if (sessionGroup == null) {
            notFound()
            return
        }

        try {
            sessionGroupService.save(sessionGroup)
        } catch (ValidationException e) {
            respond sessionGroup.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), sessionGroup.id])
                redirect sessionGroup
            }
            '*' { respond sessionGroup, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sessionGroupService.get(id)
    }

    def update(SessionGroup sessionGroup) {
        if (sessionGroup == null) {
            notFound()
            return
        }

        try {
            sessionGroupService.save(sessionGroup)
        } catch (ValidationException e) {
            respond sessionGroup.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), sessionGroup.id])
                redirect sessionGroup
            }
            '*'{ respond sessionGroup, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sessionGroupService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
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
