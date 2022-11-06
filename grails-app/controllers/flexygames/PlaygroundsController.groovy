package flexygames

class PlaygroundsController {

	def index = { redirect(action:"list") }

	def home = { redirect(action:"list") }

	def list = {
		// prepare default params values
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		if(!params.offset) params.offset = 0
		if(!params.sort) params.sort = "city"
		if(!params.order) params.order = "asc"
		
		[playgroundInstanceList: Playground.list(params), playgroundInstanceTotal: Playground.count()]
	}

	def show = {
		def playground = Playground.get(params.id)
		if (!playground) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'playground.label', default: 'Playground'), params.id])}"
			redirect(action: "list")
		}
		else {
			[playground: playground]
		}
	}
}
