package flexygames.admin

import flexygames.CarpoolProposal
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CarpoolProposalController {

    static namespace = 'admin'

    CarpoolProposalService carpoolProposalService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond carpoolProposalService.list(params), model:[carpoolProposalCount: carpoolProposalService.count()]
    }

    def show(Long id) {
        respond carpoolProposalService.get(id)
    }

    def create() {
        respond new CarpoolProposal(params)
    }

    def save(CarpoolProposal carpoolProposal) {
        if (carpoolProposal == null) {
            notFound()
            return
        }

        try {
            carpoolProposalService.save(carpoolProposal)
        } catch (ValidationException e) {
            respond carpoolProposal.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal'), carpoolProposal.id])
                redirect carpoolProposal
            }
            '*' { respond carpoolProposal, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond carpoolProposalService.get(id)
    }

    def update(CarpoolProposal carpoolProposal) {
        if (carpoolProposal == null) {
            notFound()
            return
        }

        try {
            carpoolProposalService.save(carpoolProposal)
        } catch (ValidationException e) {
            respond carpoolProposal.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal'), carpoolProposal.id])
                redirect carpoolProposal
            }
            '*'{ respond carpoolProposal, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        carpoolProposalService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
