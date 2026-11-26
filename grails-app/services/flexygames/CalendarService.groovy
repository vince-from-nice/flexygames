package flexygames

import grails.config.Config
import grails.core.support.GrailsConfigurationAware
import grails.gorm.transactions.NotTransactional
import grails.gorm.transactions.Transactional
import net.fortuna.ical4j.model.Calendar
import net.fortuna.ical4j.model.TimeZoneRegistryFactory
import net.fortuna.ical4j.model.component.VEvent
import net.fortuna.ical4j.model.property.Description
import net.fortuna.ical4j.model.property.Location
import net.fortuna.ical4j.model.property.ProdId
import net.fortuna.ical4j.model.property.Uid
import net.fortuna.ical4j.model.property.immutable.ImmutableCalScale
import net.fortuna.ical4j.model.property.immutable.ImmutableMethod
import net.fortuna.ical4j.model.property.immutable.ImmutableVersion

import java.time.ZoneId
import java.time.ZonedDateTime

@Transactional(readOnly = true)
class CalendarService implements GrailsConfigurationAware {

    static final String TIME_ZONE = 'Europe/Paris'

    String serverUrl

    @Override
    void setConfiguration(Config config) {
        serverUrl = config.getProperty('grails.serverURL', String)
    }

    String getPlayerCalendar(User player) {
        buildCalendar(player.participationsVisibleInCalendar*.session.findAll { !it.canceled })
    }

    @NotTransactional
    String buildCalendar(Collection<Session> sessions) {
        ZoneId zone = ZoneId.of(TIME_ZONE)
        Calendar calendar = new Calendar()
        calendar.add(new ProdId('-//FlexyGames//FlexyGames calendar//EN'))
        calendar.add(ImmutableVersion.VERSION_2_0)
        calendar.add(ImmutableCalScale.GREGORIAN)
        calendar.add(ImmutableMethod.PUBLISH)
        calendar.add(TimeZoneRegistryFactory.instance.createRegistry().getTimeZone(TIME_ZONE).getVTimeZone())
        sessions.each { Session s ->
            Playground pg = s.playground
            VEvent event = new VEvent(
                    ZonedDateTime.ofInstant(s.rdvDate.toInstant(), zone),
                    ZonedDateTime.ofInstant(s.endDate.toInstant(), zone),
                    s.group.name)
            // A stable UID lets calendar apps update an event instead of adding a copy.
            event.add(new Uid("session-${s.id}@flexygames.net"))
            event.add(new Description("Session link : ${serverUrl}/sessions/show/${s.id}"))
            event.add(new Location("${pg.name}, ${pg.postalAddress}"))
            calendar.add(event)
        }
        calendar.toString()
    }
}
