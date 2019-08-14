package flexygames.admin

import flexygames.BlogComment
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class BlogCommentController {

    static namespace = 'admin'

    BlogCommentService blogCommentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond blogCommentService.list(params), model:[blogCommentCount: blogCommentService.count()]
    }

    def show(Long id) {
        respond blogCommentService.get(id)
    }

    def create() {
        respond new BlogComment(params)
    }

    def save(BlogComment blogComment) {
        if (blogComment == null) {
            notFound()
            return
        }

        try {
            blogCommentService.save(blogComment)
        } catch (ValidationException e) {
            respond blogComment.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'blogComment.label', default: 'BlogComment'), blogComment.id])
                redirect blogComment
            }
            '*' { respond blogComment, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond blogCommentService.get(id)
    }

    def update(BlogComment blogComment) {
        if (blogComment == null) {
            notFound()
            return
        }

        try {
            blogCommentService.save(blogComment)
        } catch (ValidationException e) {
            respond blogComment.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'blogComment.label', default: 'BlogComment'), blogComment.id])
                redirect blogComment
            }
            '*'{ respond blogComment, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        blogCommentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'blogComment.label', default: 'BlogComment'), id])
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
