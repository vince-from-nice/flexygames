package flexygames.admin

import flexygames.Participation;

class ParticipationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [participationInstanceList: Participation.list(params), participationInstanceTotal: Participation.count()]
    }

    def create = {
        def participationInstance = new Participation()
        participationInstance.properties = params
        return [participationInstance: participationInstance]
    }

    def save = {
        def participationInstance = new Participation(params)
        if (participationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'participation.label', default: 'Participation'), participationInstance.id])}"
            redirect(action: "show", id: participationInstance.id)
        }
        else {
            render(view: "create", model: [participationInstance: participationInstance])
        }
    }

    def show = {
        def participationInstance = Participation.get(params.id)
        if (!participationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
            redirect(action: "list")
        }
        else {
            [participationInstance: participationInstance]
        }
    }

    def edit = {
        def participationInstance = Participation.get(params.id)
        if (!participationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [participationInstance: participationInstance]
        }
    }

    def update = {
        def participationInstance = Participation.get(params.id)
        if (participationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (participationInstance.version > version) {
                    
                    participationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'participation.label', default: 'Participation')] as Object[], "Another user has updated this Participation while you were editing")
                    render(view: "edit", model: [participationInstance: participationInstance])
                    return
                }
            }
            participationInstance.properties = params
            if (!participationInstance.hasErrors() && participationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'participation.label', default: 'Participation'), participationInstance.id])}"
                redirect(action: "show", id: participationInstance.id)
            }
            else {
                render(view: "edit", model: [participationInstance: participationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def participationInstance = Participation.get(params.id)
        if (participationInstance) {
            try {
                participationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'participation.label', default: 'Participation'), params.id])}"
            redirect(action: "list")
        }
    }
}
