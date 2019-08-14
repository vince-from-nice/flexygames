package flexygames.admin

import flexygames.Reminder
import flexygames.ReminderService
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ReminderController {

    static namespace = 'admin'

    ReminderService reminderService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond reminderService.list(params), model:[reminderCount: reminderService.count()]
    }

    def show(Long id) {
        respond reminderService.get(id)
    }

    def create() {
        respond new Reminder(params)
    }

    def save(Reminder reminder) {
        if (reminder == null) {
            notFound()
            return
        }

        try {
            reminderService.save(reminder)
        } catch (ValidationException e) {
            respond reminder.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminder.id])
                redirect reminder
            }
            '*' { respond reminder, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond reminderService.get(id)
    }

    def update(Reminder reminder) {
        if (reminder == null) {
            notFound()
            return
        }

        try {
            reminderService.save(reminder)
        } catch (ValidationException e) {
            respond reminder.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminder.id])
                redirect reminder
            }
            '*'{ respond reminder, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        reminderService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'reminder.label', default: 'Reminder'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
