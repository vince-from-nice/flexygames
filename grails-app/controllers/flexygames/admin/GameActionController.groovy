package flexygames.admin

import flexygames.GameAction
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class GameActionController {

    static namespace = 'admin'

    GameActionService gameActionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond gameActionService.list(params), model:[gameActionCount: gameActionService.count()]
    }

    def show(Long id) {
        respond gameActionService.get(id)
    }

    def create() {
        respond new GameAction(params)
    }

    def save(GameAction gameAction) {
        if (gameAction == null) {
            notFound()
            return
        }

        try {
            gameActionService.save(gameAction)
        } catch (ValidationException e) {
            respond gameAction.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameAction.label', default: 'GameAction'), gameAction.id])
                redirect gameAction
            }
            '*' { respond gameAction, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond gameActionService.get(id)
    }

    def update(GameAction gameAction) {
        if (gameAction == null) {
            notFound()
            return
        }

        try {
            gameActionService.save(gameAction)
        } catch (ValidationException e) {
            respond gameAction.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'gameAction.label', default: 'GameAction'), gameAction.id])
                redirect gameAction
            }
            '*'{ respond gameAction, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        gameActionService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'gameAction.label', default: 'GameAction'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
