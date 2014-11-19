package flexygames.admin

import org.springframework.dao.DataIntegrityViolationException

import flexygames.SessionWatch;

class SessionWatchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [sessionWatchInstanceList: SessionWatch.list(params), sessionWatchInstanceTotal: SessionWatch.count()]
    }

    def create() {
        [sessionWatchInstance: new SessionWatch(params)]
    }

    def save() {
        def sessionWatchInstance = new SessionWatch(params)
        if (!sessionWatchInstance.save(flush: true)) {
            render(view: "create", model: [sessionWatchInstance: sessionWatchInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), sessionWatchInstance.id])
        redirect(action: "show", id: sessionWatchInstance.id)
    }

    def show(Long id) {
        def sessionWatchInstance = SessionWatch.get(id)
        if (!sessionWatchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "list")
            return
        }

        [sessionWatchInstance: sessionWatchInstance]
    }

    def edit(Long id) {
        def sessionWatchInstance = SessionWatch.get(id)
        if (!sessionWatchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "list")
            return
        }

        [sessionWatchInstance: sessionWatchInstance]
    }

    def update(Long id, Long version) {
        def sessionWatchInstance = SessionWatch.get(id)
        if (!sessionWatchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (sessionWatchInstance.version > version) {
                sessionWatchInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sessionWatch.label', default: 'SessionWatch')] as Object[],
                          "Another user has updated this SessionWatch while you were editing")
                render(view: "edit", model: [sessionWatchInstance: sessionWatchInstance])
                return
            }
        }

        sessionWatchInstance.properties = params

        if (!sessionWatchInstance.save(flush: true)) {
            render(view: "edit", model: [sessionWatchInstance: sessionWatchInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), sessionWatchInstance.id])
        redirect(action: "show", id: sessionWatchInstance.id)
    }

    def delete(Long id) {
        def sessionWatchInstance = SessionWatch.get(id)
        if (!sessionWatchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "list")
            return
        }

        try {
            sessionWatchInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sessionWatch.label', default: 'SessionWatch'), id])
            redirect(action: "show", id: id)
        }
    }
}
