package flexygames.admin

import flexygames.Vote;

class VoteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [voteInstanceList: Vote.list(params), voteInstanceTotal: Vote.count()]
    }

    def create = {
        def voteInstance = new Vote()
        voteInstance.properties = params
        return [voteInstance: voteInstance]
    }

    def save = {
        def voteInstance = new Vote(params)
        if (voteInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'vote.label', default: 'Vote'), voteInstance.id])}"
            redirect(action: "show", id: voteInstance.id)
        }
        else {
            render(view: "create", model: [voteInstance: voteInstance])
        }
    }

    def show = {
        def voteInstance = Vote.get(params.id)
        if (!voteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
            redirect(action: "list")
        }
        else {
            [voteInstance: voteInstance]
        }
    }

    def edit = {
        def voteInstance = Vote.get(params.id)
        if (!voteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [voteInstance: voteInstance]
        }
    }

    def update = {
        def voteInstance = Vote.get(params.id)
        if (voteInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (voteInstance.version > version) {
                    
                    voteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'vote.label', default: 'Vote')] as Object[], "Another user has updated this Vote while you were editing")
                    render(view: "edit", model: [voteInstance: voteInstance])
                    return
                }
            }
            voteInstance.properties = params
            if (!voteInstance.hasErrors() && voteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'vote.label', default: 'Vote'), voteInstance.id])}"
                redirect(action: "show", id: voteInstance.id)
            }
            else {
                render(view: "edit", model: [voteInstance: voteInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def voteInstance = Vote.get(params.id)
        if (voteInstance) {
            try {
                voteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])}"
            redirect(action: "list")
        }
    }
}
