package flexygames.admin

import flexygames.GameSkill;

class GameSkillController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gameSkillInstanceList: GameSkill.list(params), gameSkillInstanceTotal: GameSkill.count()]
    }

    def create = {
        def gameSkillInstance = new GameSkill()
        gameSkillInstance.properties = params
        return [gameSkillInstance: gameSkillInstance]
    }

    def save = {
        def gameSkillInstance = new GameSkill(params)
        if (gameSkillInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), gameSkillInstance.id])}"
            redirect(action: "show", id: gameSkillInstance.id)
        }
        else {
            render(view: "create", model: [gameSkillInstance: gameSkillInstance])
        }
    }

    def show = {
        def gameSkillInstance = GameSkill.get(params.id)
        if (!gameSkillInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gameSkillInstance: gameSkillInstance]
        }
    }

    def edit = {
        def gameSkillInstance = GameSkill.get(params.id)
        if (!gameSkillInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gameSkillInstance: gameSkillInstance]
        }
    }

    def update = {
        def gameSkillInstance = GameSkill.get(params.id)
        if (gameSkillInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gameSkillInstance.version > version) {
                    
                    gameSkillInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gameSkill.label', default: 'GameSkill')] as Object[], "Another user has updated this GameSkill while you were editing")
                    render(view: "edit", model: [gameSkillInstance: gameSkillInstance])
                    return
                }
            }
            gameSkillInstance.properties = params
            if (!gameSkillInstance.hasErrors() && gameSkillInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), gameSkillInstance.id])}"
                redirect(action: "show", id: gameSkillInstance.id)
            }
            else {
                render(view: "edit", model: [gameSkillInstance: gameSkillInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gameSkillInstance = GameSkill.get(params.id)
        if (gameSkillInstance) {
            try {
                gameSkillInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameSkill.label', default: 'GameSkill'), params.id])}"
            redirect(action: "list")
        }
    }
}
