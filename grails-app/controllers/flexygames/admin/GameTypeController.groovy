package flexygames.admin

import flexygames.GameType
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class GameTypeController {

    static namespace = 'admin'

    GameTypeService gameTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond gameTypeService.list(params), model:[gameTypeCount: gameTypeService.count()]
    }

    def show(Long id) {
        respond gameTypeService.get(id)
    }

    def create() {
        respond new GameType(params)
    }

    def save(GameType gameType) {
        if (gameType == null) {
            notFound()
            return
        }

        try {
            gameTypeService.save(gameType)
        } catch (ValidationException e) {
            respond gameType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameType.label', default: 'GameType'), gameType.id])
                redirect gameType
            }
            '*' { respond gameType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond gameTypeService.get(id)
    }

    def update(GameType gameType) {
        if (gameType == null) {
            notFound()
            return
        }

        try {
            gameTypeService.save(gameType)
        } catch (ValidationException e) {
            respond gameType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'gameType.label', default: 'GameType'), gameType.id])
                redirect gameType
            }
            '*'{ respond gameType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        gameTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'gameType.label', default: 'GameType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
