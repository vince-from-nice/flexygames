package flexygames.admin

import flexygames.GameType;

class GameTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gameTypeInstanceList: GameType.list(params), gameTypeInstanceTotal: GameType.count()]
    }

    def create = {
        def gameTypeInstance = new GameType()
        gameTypeInstance.properties = params
        return [gameTypeInstance: gameTypeInstance]
    }

    def save = {
        def gameTypeInstance = new GameType(params)
        if (gameTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gameType.label', default: 'GameType'), gameTypeInstance.id])}"
            redirect(action: "show", id: gameTypeInstance.id)
        }
        else {
            render(view: "create", model: [gameTypeInstance: gameTypeInstance])
        }
    }

    def show = {
        def gameTypeInstance = GameType.get(params.id)
        if (!gameTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gameTypeInstance: gameTypeInstance]
        }
    }

    def edit = {
        def gameTypeInstance = GameType.get(params.id)
        if (!gameTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gameTypeInstance: gameTypeInstance]
        }
    }

    def update = {
        def gameTypeInstance = GameType.get(params.id)
        if (gameTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gameTypeInstance.version > version) {
                    
                    gameTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gameType.label', default: 'GameType')] as Object[], "Another user has updated this GameType while you were editing")
                    render(view: "edit", model: [gameTypeInstance: gameTypeInstance])
                    return
                }
            }
            gameTypeInstance.properties = params
            if (!gameTypeInstance.hasErrors() && gameTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gameType.label', default: 'GameType'), gameTypeInstance.id])}"
                redirect(action: "show", id: gameTypeInstance.id)
            }
            else {
                render(view: "edit", model: [gameTypeInstance: gameTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gameTypeInstance = GameType.get(params.id)
        if (gameTypeInstance) {
            try {
                gameTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gameType.label', default: 'GameType'), params.id])}"
            redirect(action: "list")
        }
    }
}
