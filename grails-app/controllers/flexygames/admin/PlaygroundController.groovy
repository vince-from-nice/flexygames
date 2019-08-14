package flexygames.admin

import flexygames.Playground
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class PlaygroundController {

    static namespace = 'admin'

    PlaygroundService playgroundService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond playgroundService.list(params), model:[playgroundCount: playgroundService.count()]
    }

    def show(Long id) {
        respond playgroundService.get(id)
    }

    def create() {
        respond new Playground(params)
    }

    def save(Playground playground) {
        if (playground == null) {
            notFound()
            return
        }

        try {
            playgroundService.save(playground)
        } catch (ValidationException e) {
            respond playground.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'playground.label', default: 'Playground'), playground.id])
                redirect playground
            }
            '*' { respond playground, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond playgroundService.get(id)
    }

    def update(Playground playground) {
        if (playground == null) {
            notFound()
            return
        }

        try {
            playgroundService.save(playground)
        } catch (ValidationException e) {
            respond playground.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'playground.label', default: 'Playground'), playground.id])
                redirect playground
            }
            '*'{ respond playground, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        playgroundService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'playground.label', default: 'Playground'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
