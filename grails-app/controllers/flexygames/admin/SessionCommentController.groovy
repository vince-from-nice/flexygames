package flexygames.admin

import flexygames.SessionComment

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SessionCommentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SessionComment.list(params), model:[sessionCommentInstanceCount: SessionComment.count()]
    }

    def show(SessionComment sessionCommentInstance) {
        respond sessionCommentInstance
    }

    def create() {
        respond new SessionComment(params)
    }

    @Transactional
    def save(SessionComment sessionCommentInstance) {
        if (sessionCommentInstance == null) {
            notFound()
            return
        }

        if (sessionCommentInstance.hasErrors()) {
            respond sessionCommentInstance.errors, view:'create'
            return
        }

        sessionCommentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sessionComment.label', default: 'SessionComment'), sessionCommentInstance.id])
                redirect sessionCommentInstance
            }
            '*' { respond sessionCommentInstance, [status: CREATED] }
        }
    }

    def edit(SessionComment sessionCommentInstance) {
        respond sessionCommentInstance
    }

    @Transactional
    def update(SessionComment sessionCommentInstance) {
        if (sessionCommentInstance == null) {
            notFound()
            return
        }

        if (sessionCommentInstance.hasErrors()) {
            respond sessionCommentInstance.errors, view:'edit'
            return
        }

        sessionCommentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SessionComment.label', default: 'SessionComment'), sessionCommentInstance.id])
                redirect sessionCommentInstance
            }
            '*'{ respond sessionCommentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SessionComment sessionCommentInstance) {

        if (sessionCommentInstance == null) {
            notFound()
            return
        }

        sessionCommentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SessionComment.label', default: 'SessionComment'), sessionCommentInstance.id])
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
