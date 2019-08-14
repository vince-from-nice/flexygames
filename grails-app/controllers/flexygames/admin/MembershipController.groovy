package flexygames.admin

import flexygames.Membership
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class MembershipController {

    static namespace = 'admin'

    MembershipService membershipService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond membershipService.list(params), model:[membershipCount: membershipService.count()]
    }

    def show(Long id) {
        respond membershipService.get(id)
    }

    def create() {
        respond new Membership(params)
    }

    def save(Membership membership) {
        if (membership == null) {
            notFound()
            return
        }

        try {
            membershipService.save(membership)
        } catch (ValidationException e) {
            respond membership.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'membership.label', default: 'Membership'), membership.id])
                redirect membership
            }
            '*' { respond membership, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond membershipService.get(id)
    }

    def update(Membership membership) {
        if (membership == null) {
            notFound()
            return
        }

        try {
            membershipService.save(membership)
        } catch (ValidationException e) {
            respond membership.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'membership.label', default: 'Membership'), membership.id])
                redirect membership
            }
            '*'{ respond membership, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        membershipService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'membership.label', default: 'Membership'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'membership.label', default: 'Membership'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
