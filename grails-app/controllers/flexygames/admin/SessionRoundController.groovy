package flexygames.admin

import flexygames.SessionRound;

class SessionRoundController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sessionRoundInstanceList: SessionRound.list(params), sessionRoundInstanceTotal: SessionRound.count()]
    }

    def create = {
        def sessionRoundInstance = new SessionRound()
        sessionRoundInstance.properties = params
        return [sessionRoundInstance: sessionRoundInstance]
    }

    def save = {
        def sessionRoundInstance = new SessionRound(params)
        if (sessionRoundInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), sessionRoundInstance.id])}"
            redirect(action: "show", id: sessionRoundInstance.id)
        }
        else {
            render(view: "create", model: [sessionRoundInstance: sessionRoundInstance])
        }
    }

    def show = {
        def sessionRoundInstance = SessionRound.get(params.id)
        if (!sessionRoundInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sessionRoundInstance: sessionRoundInstance]
        }
    }

    def edit = {
        def sessionRoundInstance = SessionRound.get(params.id)
        if (!sessionRoundInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sessionRoundInstance: sessionRoundInstance]
        }
    }

    def update = {
        def sessionRoundInstance = SessionRound.get(params.id)
        if (sessionRoundInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sessionRoundInstance.version > version) {
                    
                    sessionRoundInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sessionRound.label', default: 'SessionRound')] as Object[], "Another user has updated this SessionRound while you were editing")
                    render(view: "edit", model: [sessionRoundInstance: sessionRoundInstance])
                    return
                }
            }
            sessionRoundInstance.properties = params
            if (!sessionRoundInstance.hasErrors() && sessionRoundInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), sessionRoundInstance.id])}"
                redirect(action: "show", id: sessionRoundInstance.id)
            }
            else {
                render(view: "edit", model: [sessionRoundInstance: sessionRoundInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def sessionRoundInstance = SessionRound.get(params.id)
        if (sessionRoundInstance) {
            try {
                sessionRoundInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sessionRound.label', default: 'SessionRound'), params.id])}"
            redirect(action: "list")
        }
    }
}
