package flexygames

import ch.silviowangler.grails.icalender.CalendarExporter
import grails.gorm.transactions.Transactional
import net.fortuna.ical4j.model.DateTime
import net.fortuna.ical4j.model.TimeZoneRegistry
import net.fortuna.ical4j.model.TimeZoneRegistryFactory
import net.fortuna.ical4j.model.component.VTimeZone

@Transactional(readOnly = true)
class CalendarService implements CalendarExporter {

    def getPlayerCalendar(User player) {
        TimeZoneRegistry registry = TimeZoneRegistryFactory.instance.createRegistry()
        TimeZone timezone = registry.getTimeZone("Europe/Paris")
        VTimeZone tz = timezone.vTimeZone
        renderCalendar {
            calendar {
                events {
                    for (Participation p in player.participationsVisibleInCalendar) {
                        Session s = p.session
                        if (!s.canceled) {
                            Playground pg = s.playground
                            DateTime start = new DateTime(s.rdvDate.getTime());
                            start.setTimeZone(timezone);
                            DateTime end = new DateTime(s.endDate.getTime());
                            end.setTimeZone(timezone);
                            event(
                                    start: start,
                                    end: end,
                                    //tzId: 'Europe/Paris',
                                    tzId: tz.timeZoneId,
                                    description: 'Session link : ' + grailsApplication.config.grails.serverURL + '/sessions/show/' + s.id,
                                    location: pg.name + ', ' + pg.postalAddress,
                                    streetAddress: pg.street,
                                    locality: pg.city,
                                    summary: s.group.name
                            )
                        }
                    }
                }
            }
        }
    }
}
