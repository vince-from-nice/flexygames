package flexygames

import grails.testing.web.taglib.TagLibUnitTest
import spock.lang.Specification

class FlexyTagLibSpec extends Specification implements TagLibUnitTest<FlexyTagLib> {

    void "a team with its own logo shows the logo"() {
        when:
        String html = applyTemplate('<flexy:teamLogo team="${team}" />', [team: new Team(name: 'ASAS UrbanFoot Team', logoName: 'team-3.png')])

        then:
        html.startsWith('<img class="team-logo"')
        html.contains('images/team/team-3.png"')
        html.contains('alt="ASAS UrbanFoot Team"')
    }

    void "a team named #name without logo shows the initials #initials"() {
        when:
        String html = applyTemplate('<flexy:teamLogo team="${team}" />', [team: new Team(name: name, logoName: logoName)])

        then:
        html.contains('class="team-monogram team-logo"')
        html.contains(">${initials}</span>")
        !html.contains('<img')

        where:
        name                     | logoName      || initials
        'ASAS UrbanFoot Team'    | 'no-logo.png' || 'AU'
        'ASAS Volleyball Guests' | null          || 'AV'
        'Paris'                  | 'no-logo.png' || 'P'
    }

    void "the large size uses the large class"() {
        expect:
        applyTemplate('<flexy:teamLogo team="${team}" size="large" />', [team: new Team(name: 'Paris', logoName: null)])
                .contains('class="team-monogram team-logo-large"')
    }
}
