package flexygames.admin

import flexygames.CarpoolProposal

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class CarpoolProposalController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CarpoolProposal.list(params), model:[carpoolProposalInstanceCount: CarpoolProposal.count()]
    }

    def show(CarpoolProposal carpoolProposalInstance) {
        respond carpoolProposalInstance
    }

    def create() {
        respond new CarpoolProposal(params)
    }

    @Transactional
    def save(CarpoolProposal carpoolProposalInstance) {
        if (carpoolProposalInstance == null) {
            notFound()
            return
        }

        if (carpoolProposalInstance.hasErrors()) {
            respond carpoolProposalInstance.errors, view:'create'
            return
        }

        carpoolProposalInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'carpoolProposal.label', default: 'CarpoolProposal'), carpoolProposalInstance.id])
                redirect carpoolProposalInstance
            }
            '*' { respond carpoolProposalInstance, [status: CREATED] }
        }
    }

    def edit(CarpoolProposal carpoolProposalInstance) {
        respond carpoolProposalInstance
    }

    @Transactional
    def update(CarpoolProposal carpoolProposalInstance) {
        if (carpoolProposalInstance == null) {
            notFound()
            return
        }

        if (carpoolProposalInstance.hasErrors()) {
            respond carpoolProposalInstance.errors, view:'edit'
            return
        }

        carpoolProposalInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CarpoolProposal.label', default: 'CarpoolProposal'), carpoolProposalInstance.id])
                redirect carpoolProposalInstance
            }
            '*'{ respond carpoolProposalInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CarpoolProposal carpoolProposalInstance) {

        if (carpoolProposalInstance == null) {
            notFound()
            return
        }

        carpoolProposalInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CarpoolProposal.label', default: 'CarpoolProposal'), carpoolProposalInstance.id])
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
