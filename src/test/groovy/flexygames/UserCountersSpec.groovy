package flexygames

import spock.lang.Specification

class UserCountersSpec extends Specification {

    void "a new user starts every counter that the services increment at zero"() {
        when:
        User user = new User()

        then:
        [user.commentCounter, user.participationCounter, user.voteCounter, user.votingScoreCounter, user.actionCounter,
         user.absenceCounter, user.delayCounter, user.gateCrashCounter, user.waitingListCounter] == [0] * 9
    }
}
