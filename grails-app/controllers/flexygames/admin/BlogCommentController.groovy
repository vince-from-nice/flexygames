package flexygames.admin

import flexygames.BlogComment

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class BlogCommentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BlogComment.list(params), model:[blogCommentInstanceCount: BlogComment.count()]
    }

    def show(BlogComment blogCommentInstance) {
        respond blogCommentInstance
    }

    def create() {
        respond new BlogComment(params)
    }

    @Transactional
    def save(BlogComment blogCommentInstance) {
        if (blogCommentInstance == null) {
            notFound()
            return
        }

        if (blogCommentInstance.hasErrors()) {
            respond blogCommentInstance.errors, view:'create'
            return
        }

        blogCommentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'blogComment.label', default: 'BlogComment'), blogCommentInstance.id])
                redirect blogCommentInstance
            }
            '*' { respond blogCommentInstance, [status: CREATED] }
        }
    }

    def edit(BlogComment blogCommentInstance) {
        respond blogCommentInstance
    }

    @Transactional
    def update(BlogComment blogCommentInstance) {
        if (blogCommentInstance == null) {
            notFound()
            return
        }

        if (blogCommentInstance.hasErrors()) {
            respond blogCommentInstance.errors, view:'edit'
            return
        }

        blogCommentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BlogComment.label', default: 'BlogComment'), blogCommentInstance.id])
                redirect blogCommentInstance
            }
            '*'{ respond blogCommentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BlogComment blogCommentInstance) {

        if (blogCommentInstance == null) {
            notFound()
            return
        }

        blogCommentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BlogComment.label', default: 'BlogComment'), blogCommentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'blogComment.label', default: 'BlogComment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
