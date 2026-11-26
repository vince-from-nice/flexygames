package flexygames

import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

import java.text.SimpleDateFormat

class CalendarServiceSpec extends Specification implements ServiceUnitTest<CalendarService> {

    Closure doWithConfig() {
        { config -> config.grails.serverURL = 'https://www.flexygames.net' }
    }

    void "a session is an event in Paris time, from the meeting time to the end of the session"() {
        given:
        def session = new Session(
                date: parisTime('2026-12-01 21:00'),
                rdvBeforeStart: 15,
                duration: 90,
                group: new SessionGroup(name: 'Foot à 5 du mardi'),
                playground: new Playground(name: 'UrbanFoot', street: '1 rue du Stade', zip: '94380', city: 'Bonneuil'))
        session.id = 42

        when:
        String ics = unfold(service.buildCalendar([session]))

        then:
        ics.startsWith('BEGIN:VCALENDAR')
        ics.contains('METHOD:PUBLISH')
        ics.contains('BEGIN:VTIMEZONE\r\nTZID:Europe/Paris')
        ics.contains('DTSTART;TZID=Europe/Paris:20261201T204500')
        ics.contains('DTEND;TZID=Europe/Paris:20261201T223000')
        ics.contains('SUMMARY:Foot à 5 du mardi')
        ics.contains('UID:session-42@flexygames.net')
        ics.contains('LOCATION:UrbanFoot\\, 1 rue du Stade\\, 94380\\, Bonneuil\\, France')
        ics.contains('DESCRIPTION:Session link : https://www.flexygames.net/sessions/show/42')
    }

    void "a calendar without sessions has no event"() {
        expect:
        !service.buildCalendar([]).contains('BEGIN:VEVENT')
    }

    private static Date parisTime(String value) {
        def format = new SimpleDateFormat('yyyy-MM-dd HH:mm')
        format.timeZone = TimeZone.getTimeZone('Europe/Paris')
        format.parse(value)
    }

    // iCalendar folds lines longer than 75 octets
    private static String unfold(String ics) {
        ics.replace('\r\n ', '')
    }
}
