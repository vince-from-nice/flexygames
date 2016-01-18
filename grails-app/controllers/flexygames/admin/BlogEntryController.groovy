package flexygames.admin

import flexygames.BlogEntry

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BlogEntryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BlogEntry.list(params), model:[blogEntryInstanceCount: BlogEntry.count()]
    }

    def show(BlogEntry blogEntryInstance) {
        respond blogEntryInstance
    }

    def create() {
        respond new BlogEntry(params)
    }

    @Transactional
    def save(BlogEntry blogEntryInstance) {
        if (blogEntryInstance == null) {
            notFound()
            return
        }

        if (blogEntryInstance.hasErrors()) {
            respond blogEntryInstance.errors, view:'create'
            return
        }

        blogEntryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'blogEntry.label', default: 'BlogEntry'), blogEntryInstance.id])
                redirect blogEntryInstance
            }
            '*' { respond blogEntryInstance, [status: CREATED] }
        }
    }

    def edit(BlogEntry blogEntryInstance) {
        respond blogEntryInstance
    }

    @Transactional
    def update(BlogEntry blogEntryInstance) {
        if (blogEntryInstance == null) {
            notFound()
            return
        }

        if (blogEntryInstance.hasErrors()) {
            respond blogEntryInstance.errors, view:'edit'
            return
        }

        blogEntryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BlogEntry.label', default: 'BlogEntry'), blogEntryInstance.id])
                redirect blogEntryInstance
            }
            '*'{ respond blogEntryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BlogEntry blogEntryInstance) {

        if (blogEntryInstance == null) {
            notFound()
            return
        }

        blogEntryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BlogEntry.label', default: 'BlogEntry'), blogEntryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'blogEntry.label', default: 'BlogEntry'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
