package flexygames.admin

import flexygames.GameAction;

class GameActionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gameActionInstanceList: GameAction.list(params), gameActionInstanceTotal: GameAction.count()]
    }

    def create = {
        def gameActionInstance = new GameAction()
        gameActionInstance.properties = params
        return [gameActionInstance: gameActionInstance]
    }

    def save = {
        def gameActionInstance = new GameAction(params)
        if (gameActionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gameAction.label', default: 'GameAction'), gameActionInstance.id])}"
            redirect(action: "show", id: gameActionInstance.id)
        }
        else {
            render(view: "create", model: [gameActionInstance: gameActionInstance])
        }
    }

    def show = {
        def gameActionInstance = GameAction.get(params.id)
        if (!gameActionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gameActionInstance: gameActionInstance]
        }
    }

    def edit = {
        def gameActionInstance = GameAction.get(params.id)
        if (!gameActionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gameActionInstance: gameActionInstance]
        }
    }

    def update = {
        def gameActionInstance = GameAction.get(params.id)
        if (gameActionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gameActionInstance.version > version) {
                    
                    gameActionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gameAction.label', default: 'GameAction')] as Object[], "Another user has updated this GameAction while you were editing")
                    render(view: "edit", model: [gameActionInstance: gameActionInstance])
                    return
                }
            }
            gameActionInstance.properties = params
            if (!gameActionInstance.hasErrors() && gameActionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gameAction.label', default: 'GameAction'), gameActionInstance.id])}"
                redirect(action: "show", id: gameActionInstance.id)
            }
            else {
                render(view: "edit", model: [gameActionInstance: gameActionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gameActionInstance = GameAction.get(params.id)
        if (gameActionInstance) {
            try {
                gameActionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameAction.label', default: 'GameAction'), params.id])}"
            redirect(action: "list")
        }
    }
}
