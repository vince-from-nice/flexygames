package flexygames.admin

import flexygames.CarpoolRequest
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CarpoolRequestController {

    static namespace = 'admin'

    CarpoolRequestService carpoolRequestService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond carpoolRequestService.list(params), model:[carpoolRequestCount: carpoolRequestService.count()]
    }

    def show(Long id) {
        respond carpoolRequestService.get(id)
    }

    def create() {
        respond new CarpoolRequest(params)
    }

    def save(CarpoolRequest carpoolRequest) {
        if (carpoolRequest == null) {
            notFound()
            return
        }

        try {
            carpoolRequestService.save(carpoolRequest)
        } catch (ValidationException e) {
            respond carpoolRequest.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest'), carpoolRequest.id])
                redirect carpoolRequest
            }
            '*' { respond carpoolRequest, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond carpoolRequestService.get(id)
    }

    def update(CarpoolRequest carpoolRequest) {
        if (carpoolRequest == null) {
            notFound()
            return
        }

        try {
            carpoolRequestService.save(carpoolRequest)
        } catch (ValidationException e) {
            respond carpoolRequest.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest'), carpoolRequest.id])
                redirect carpoolRequest
            }
            '*'{ respond carpoolRequest, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        carpoolRequestService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest'), id])
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
