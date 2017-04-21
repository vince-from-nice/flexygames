package flexygames.admin

import flexygames.CarpoolRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CarpoolRequestController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CarpoolRequest.list(params), model:[carpoolRequestInstanceCount: CarpoolRequest.count()]
    }

    def show(CarpoolRequest carpoolRequestInstance) {
        respond carpoolRequestInstance
    }

    def create() {
        respond new CarpoolRequest(params)
    }

    @Transactional
    def save(CarpoolRequest carpoolRequestInstance) {
        if (carpoolRequestInstance == null) {
            notFound()
            return
        }

        if (carpoolRequestInstance.hasErrors()) {
            respond carpoolRequestInstance.errors, view:'create'
            return
        }

        carpoolRequestInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest'), carpoolRequestInstance.id])
                redirect carpoolRequestInstance
            }
            '*' { respond carpoolRequestInstance, [status: CREATED] }
        }
    }

    def edit(CarpoolRequest carpoolRequestInstance) {
        respond carpoolRequestInstance
    }

    @Transactional
    def update(CarpoolRequest carpoolRequestInstance) {
        if (carpoolRequestInstance == null) {
            notFound()
            return
        }

        if (carpoolRequestInstance.hasErrors()) {
            respond carpoolRequestInstance.errors, view:'edit'
            return
        }

        carpoolRequestInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CarpoolRequest.label', default: 'CarpoolRequest'), carpoolRequestInstance.id])
                redirect carpoolRequestInstance
            }
            '*'{ respond carpoolRequestInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CarpoolRequest carpoolRequestInstance) {

        if (carpoolRequestInstance == null) {
            notFound()
            return
        }

        carpoolRequestInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CarpoolRequest.label', default: 'CarpoolRequest'), carpoolRequestInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
