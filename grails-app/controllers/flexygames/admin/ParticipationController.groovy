package flexygames.admin

import flexygames.Participation
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ParticipationController {

    static namespace = 'admin'

    ParticipationService participationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond participationService.list(params), model:[participationCount: participationService.count()]
    }

    def show(Long id) {
        respond participationService.get(id)
    }

    def create() {
        respond new Participation(params)
    }

    def save(Participation participation) {
        if (participation == null) {
            notFound()
            return
        }

        try {
            participationService.save(participation)
        } catch (ValidationException e) {
            respond participation.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'participation.label', default: 'Participation'), participation.id])
                redirect participation
            }
            '*' { respond participation, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond participationService.get(id)
    }

    def update(Participation participation) {
        if (participation == null) {
            notFound()
            return
        }

        try {
            participationService.save(participation)
        } catch (ValidationException e) {
            respond participation.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'participation.label', default: 'Participation'), participation.id])
                redirect participation
            }
            '*'{ respond participation, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        participationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'participation.label', default: 'Participation'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
