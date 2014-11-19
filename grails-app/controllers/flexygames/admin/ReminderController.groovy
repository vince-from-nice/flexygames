package flexygames.admin

import flexygames.Reminder;

class ReminderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [reminderInstanceList: Reminder.list(params), reminderInstanceTotal: Reminder.count()]
    }

    def create = {
        def reminderInstance = new Reminder()
        reminderInstance.properties = params
        return [reminderInstance: reminderInstance]
    }

    def save = {
        def reminderInstance = new Reminder(params)
        if (reminderInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminderInstance.id])}"
            redirect(action: "show", id: reminderInstance.id)
        }
        else {
            render(view: "create", model: [reminderInstance: reminderInstance])
        }
    }

    def show = {
        def reminderInstance = Reminder.get(params.id)
        if (!reminderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
            redirect(action: "list")
        }
        else {
            [reminderInstance: reminderInstance]
        }
    }

    def edit = {
        def reminderInstance = Reminder.get(params.id)
        if (!reminderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [reminderInstance: reminderInstance]
        }
    }

    def update = {
        def reminderInstance = Reminder.get(params.id)
        if (reminderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (reminderInstance.version > version) {
                    
                    reminderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'reminder.label', default: 'Reminder')] as Object[], "Another user has updated this Reminder while you were editing")
                    render(view: "edit", model: [reminderInstance: reminderInstance])
                    return
                }
            }
            reminderInstance.properties = params
            if (!reminderInstance.hasErrors() && reminderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminderInstance.id])}"
                redirect(action: "show", id: reminderInstance.id)
            }
            else {
                render(view: "edit", model: [reminderInstance: reminderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def reminderInstance = Reminder.get(params.id)
        if (reminderInstance) {
            try {
                reminderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])}"
            redirect(action: "list")
        }
    }
}
