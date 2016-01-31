package flexygames.admin

import flexygames.Team

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TeamController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Team.list(params), model:[teamInstanceCount: Team.count()]
    }

    def show(Team teamInstance) {
        respond teamInstance
    }

    def create() {
        respond new Team(params)
    }

    @Transactional
    def save(Team teamInstance) {
        if (teamInstance == null) {
            notFound()
            return
        }

        if (teamInstance.hasErrors()) {
            respond teamInstance.errors, view:'create'
            return
        }

        teamInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'team.label', default: 'Team'), teamInstance.id])
                redirect teamInstance
            }
            '*' { respond teamInstance, [status: CREATED] }
        }
    }

    def edit(Team teamInstance) {
        respond teamInstance
    }

    @Transactional
    def update(Team teamInstance) {
        if (teamInstance == null) {
            notFound()
            return
        }

        if (teamInstance.hasErrors()) {
            respond teamInstance.errors, view:'edit'
            return
        }

        teamInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Team.label', default: 'Team'), teamInstance.id])
                redirect teamInstance
            }
            '*'{ respond teamInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Team teamInstance) {

        if (teamInstance == null) {
            notFound()
            return
        }

        teamInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Team.label', default: 'Team'), teamInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
