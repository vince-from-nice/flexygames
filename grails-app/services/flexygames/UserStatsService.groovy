package flexygames

import grails.gorm.transactions.Transactional


class UserStatsService {

    @Transactional (readOnly = true)
    def getUserStats(User player) {
        def userStats = [:]

        def allEffectiveParticipations = player.getEffectiveParticipations()
        def allEffectiveSessions = player.getAllEffectiveSessions()
        def allSessionGroups = player.getAllEffectiveSessionGroups()

        // TODO fetch in one shot from the DB the playersInTeam* of all rounds
        def allRounds = []
        if (allEffectiveSessions.size() > 0) {
            allRounds = SessionRound.findAllBySessionInList(allEffectiveSessions)
        }

        userStats.player = player
        userStats.sessionGroups = []
        allSessionGroups.each { sessionGroup ->
            def group = [:]
            group.id = sessionGroup.id
            group.name = sessionGroup.name
            group.firstDefaultTeam = sessionGroup.defaultTeams.first()
            group.effectiveParticipations = 0
            group.actions = 0
            group.rounds = 0
            group.wins = 0
            group.draws = 0
            group.defeats = 0
            group.votingScore = 0
            userStats.sessionGroups << group
        }

        def allActions = player.actions
        allActions.each { action ->
            def group = userStats.sessionGroups.find { it.id == action.sessionRound.session.group.id }
            if (group != null) {
                group.actions++
            }
        }

        allEffectiveParticipations.each { part ->
            def group = userStats.sessionGroups.find { it.id == part.session.group.id }
            if (group != null) {
                group.effectiveParticipations++
                group.wins += part.getWins().size()
                group.draws += part.getDraws().size()
                group.defeats += part.getDefeats().size()
            }
        }

        allRounds.each { round ->
            def group = userStats.sessionGroups.find { it.id == round.session.group.id }
            if (group != null) {
                if (player in round.playersForTeamA || player in round.playersForTeamB) {
                    group.rounds++
                }
            }
        }

        player.receivedVotes.each { vote ->
            def group = userStats.sessionGroups.find { it.id == vote.session.group.id }
            if (group != null) {
                group.votingScore += vote.score
            }
        }

        return userStats
    }

    @Transactional ()
    def refreshCountersForAllUsers() {
        for (User user in User.getAll()) {
            user.setParticipationCounter(user.getEffectiveParticipations().size())
            user.setAbsenceCounter(user.countParticipationsByStatus(Participation.Status.UNDONE.code()))
            user.setGateCrashCounter(user.countParticipationsByStatus(Participation.Status.DONE_BAD.code()))
            user.setDelayCounter(user.countParticipationsByStatus(Participation.Status.DONE_LATE.code()))
            user.setWaitingListCounter(user.countParticipationsByStatus(Participation.Status.WAITING_LIST.code()))
            user.setVoteCounter(user.getVotes().size())
            user.setVotingScoreCounter(user.getVotingScore())
            user.setActionCounter(user.getActions().size())
            user.setCommentCounter(SessionComment.findAllByUser(user).size() + BlogComment.findAllByUser(user).size())
        }
    }
}