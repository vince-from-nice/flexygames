package flexygames.admin

import org.springframework.dao.DataIntegrityViolationException

import flexygames.SessionGroup;

class SessionGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [sessionGroupInstanceList: SessionGroup.list(params), sessionGroupInstanceTotal: SessionGroup.count()]
    }

    def create() {
        [sessionGroupInstance: new SessionGroup(params)]
    }

    def save() {
        def sessionGroupInstance = new SessionGroup(params)
        if (!sessionGroupInstance.save(flush: true)) {
            render(view: "create", model: [sessionGroupInstance: sessionGroupInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), sessionGroupInstance.id])
        redirect(action: "show", id: sessionGroupInstance.id)
    }

    def show(Long id) {
        def sessionGroupInstance = SessionGroup.get(id)
        if (!sessionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "list")
            return
        }

        [sessionGroupInstance: sessionGroupInstance]
    }

    def edit(Long id) {
        def sessionGroupInstance = SessionGroup.get(id)
        if (!sessionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "list")
            return
        }

        [sessionGroupInstance: sessionGroupInstance]
    }

    def update(Long id, Long version) {
        def sessionGroupInstance = SessionGroup.get(id)
        if (!sessionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (sessionGroupInstance.version > version) {
                sessionGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sessionGroup.label', default: 'SessionGroup')] as Object[],
                          "Another user has updated this SessionGroup while you were editing")
                render(view: "edit", model: [sessionGroupInstance: sessionGroupInstance])
                return
            }
        }

        sessionGroupInstance.properties = params

        if (!sessionGroupInstance.save(flush: true)) {
            render(view: "edit", model: [sessionGroupInstance: sessionGroupInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), sessionGroupInstance.id])
        redirect(action: "show", id: sessionGroupInstance.id)
    }

    def delete(Long id) {
        def sessionGroupInstance = SessionGroup.get(id)
        if (!sessionGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "list")
            return
        }

        try {
            sessionGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sessionGroup.label', default: 'SessionGroup'), id])
            redirect(action: "show", id: id)
        }
    }
}
