package flexygames.admin

import flexygames.Vote
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class VoteController {

    static namespace = 'admin'

    VoteService voteService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond voteService.list(params), model:[voteCount: voteService.count()]
    }

    def show(Long id) {
        respond voteService.get(id)
    }

    def create() {
        respond new Vote(params)
    }

    def save(Vote vote) {
        if (vote == null) {
            notFound()
            return
        }

        try {
            voteService.save(vote)
        } catch (ValidationException e) {
            respond vote.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'vote.label', default: 'Vote'), vote.id])
                redirect vote
            }
            '*' { respond vote, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond voteService.get(id)
    }

    def update(Vote vote) {
        if (vote == null) {
            notFound()
            return
        }

        try {
            voteService.save(vote)
        } catch (ValidationException e) {
            respond vote.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'vote.label', default: 'Vote'), vote.id])
                redirect vote
            }
            '*'{ respond vote, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        voteService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'vote.label', default: 'Vote'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'vote.label', default: 'Vote'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
