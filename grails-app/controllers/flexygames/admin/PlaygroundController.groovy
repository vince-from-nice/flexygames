package flexygames.admin

import org.springframework.dao.DataIntegrityViolationException

import flexygames.Playground;

class PlaygroundController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [playgroundInstanceList: Playground.list(params), playgroundInstanceTotal: Playground.count()]
    }

    def create() {
        [playgroundInstance: new Playground(params)]
    }

    def save() {
        def playgroundInstance = new Playground(params)
        if (!playgroundInstance.save(flush: true)) {
            render(view: "create", model: [playgroundInstance: playgroundInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'playground.label', default: 'Playground'), playgroundInstance.id])
        redirect(action: "show", id: playgroundInstance.id)
    }

    def show() {
        def playgroundInstance = Playground.get(params.id)
        if (!playgroundInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "list")
            return
        }

        [playgroundInstance: playgroundInstance]
    }

    def edit() {
        def playgroundInstance = Playground.get(params.id)
        if (!playgroundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "list")
            return
        }

        [playgroundInstance: playgroundInstance]
    }

    def update() {
        def playgroundInstance = Playground.get(params.id)
        if (!playgroundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (playgroundInstance.version > version) {
                playgroundInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'playground.label', default: 'Playground')] as Object[],
                          "Another user has updated this Playground while you were editing")
                render(view: "edit", model: [playgroundInstance: playgroundInstance])
                return
            }
        }

		playgroundInstance.properties = params
		
		// Bug au niveau HTML (http://jira.grails.org/browse/GRAILS-8143) mais y aussi pb ici, on perd les décimales !
		Float lat = Float.parseFloat(params.latitude)
		Float lon = Float.parseFloat(params.longitude)
		playgroundInstance.latitude = lat
		playgroundInstance.longitude = lon
		
        if (!playgroundInstance.save(flush: true)) {
            render(view: "edit", model: [playgroundInstance: playgroundInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'playground.label', default: 'Playground'), playgroundInstance.id])
        redirect(action: "show", id: playgroundInstance.id)
    }

    def delete() {
        def playgroundInstance = Playground.get(params.id)
        if (!playgroundInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "list")
            return
        }

        try {
            playgroundInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
