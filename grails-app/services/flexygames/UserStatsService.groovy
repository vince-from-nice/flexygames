package flexygames

import grails.gorm.transactions.Transactional

@Transactional (readOnly = true)
class UserStatsService {

    def getUserStats(User player) {
        def userStats = [:]

        def allEffectiveParticipations = player.getEffectiveParticipations()
        def allEffectiveSessions = player.getAllEffectiveSessions()
        def allSessionGroups = player.getAllEffectiveSessionGroups()

        // TODO fetch in one shot from the DB the playersInTeam* of all rounds
        def allRounds = SessionRound.findAllBySessionInList(allEffectiveSessions)
        //def playersInTeamA = User.findAll
//        println "User has " + allRounds.size() + " rounds:"
//				allRounds.each { round ->
//					println "\t$round: "
//					println "\t\tplayers in teamA: " + round.playersForTeamA.size()
//					println "\t\tplayers in teamB: " + round.playersForTeamB.size()
//				}

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
}