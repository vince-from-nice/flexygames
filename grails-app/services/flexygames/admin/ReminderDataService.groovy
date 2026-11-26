package flexygames.admin

import flexygames.Reminder
import grails.gorm.services.Service

// Not named ReminderService: flexygames.ReminderService already owns the "reminderService" bean.
@Service(Reminder)
interface ReminderDataService {

    Reminder get(Serializable id)

    List<Reminder> list(Map args)

    Long count()

    void delete(Serializable id)

    Reminder save(Reminder reminder)

}
