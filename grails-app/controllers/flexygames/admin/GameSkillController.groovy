package flexygames.admin

import flexygames.GameSkill
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class GameSkillController {

    static namespace = 'admin'

    GameSkillService gameSkillService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond gameSkillService.list(params), model:[gameSkillCount: gameSkillService.count()]
    }

    def show(Long id) {
        respond gameSkillService.get(id)
    }

    def create() {
        respond new GameSkill(params)
    }

    def save(GameSkill gameSkill) {
        if (gameSkill == null) {
            notFound()
            return
        }

        try {
            gameSkillService.save(gameSkill)
        } catch (ValidationException e) {
            respond gameSkill.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), gameSkill.id])
                redirect gameSkill
            }
            '*' { respond gameSkill, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond gameSkillService.get(id)
    }

    def update(GameSkill gameSkill) {
        if (gameSkill == null) {
            notFound()
            return
        }

        try {
            gameSkillService.save(gameSkill)
        } catch (ValidationException e) {
            respond gameSkill.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), gameSkill.id])
                redirect gameSkill
            }
            '*'{ respond gameSkill, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        gameSkillService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
