package flexygames.admin

import flexygames.SessionComment
import flexygames.admin.SessionCommentService
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SessionCommentController {

    static namespace = 'admin'

    SessionCommentService sessionCommentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sessionCommentService.list(params), model:[sessionCommentCount: sessionCommentService.count()]
    }

    def show(Long id) {
        respond sessionCommentService.get(id)
    }

    def create() {
        respond new SessionComment(params)
    }

    def save(SessionComment sessionComment) {
        if (sessionComment == null) {
            notFound()
            return
        }

        try {
            sessionCommentService.save(sessionComment)
        } catch (ValidationException e) {
            respond sessionComment.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionComment.label', default: 'SessionComment'), sessionComment.id])
                redirect sessionComment
            }
            '*' { respond sessionComment, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sessionCommentService.get(id)
    }

    def update(SessionComment sessionComment) {
        if (sessionComment == null) {
            notFound()
            return
        }

        try {
            sessionCommentService.save(sessionComment)
        } catch (ValidationException e) {
            respond sessionComment.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionComment.label', default: 'SessionComment'), sessionComment.id])
                redirect sessionComment
            }
            '*'{ respond sessionComment, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sessionCommentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionComment.label', default: 'SessionComment'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionComment.label', default: 'SessionComment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
