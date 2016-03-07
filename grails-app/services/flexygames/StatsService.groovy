package flexygames

import grails.transaction.Transactional

@Transactional
class StatsService {

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
            def group = userStats.sessionGroups.find{it.id == action.sessionRound.session.group.id}
            if (group != null) {
                group.actions++
            }
        }

        allEffectiveParticipations.each { part ->
            def group = userStats.sessionGroups.find{it.id == part.session.group.id}
            if (group != null) {
                group.effectiveParticipations++
                group.wins += part.getWins().size()
                group.draws += part.getDraws().size()
                group.defeats += part.getDefeats().size()
            }
        }

        allRounds.each { round ->
            def group = userStats.sessionGroups.find{it.id == round.session.group.id}
            if (group != null) {
                if (player in round.playersForTeamA || player in round.playersForTeamB) {
                    group.rounds++
                }
            }
        }

        player.receivedVotes.each { vote ->
            def group = userStats.sessionGroups.find{it.id == vote.session.group.id}
            if (group != null) {
                group.votingScore += vote.score
            }
        }

        return userStats
    }

    def getTeamMembersRanking(Team team, String criteria, SessionGroup sessionGroup) {
        TreeMap<User, Number> memberRankingMap = new TreeMap<User, Number>()
        def MIN_PARTS_FOR_AVERAGE_SCORING = 10
        def members = team.members
        if (!sessionGroup) {
            // TODO preload in one shot the default teams of session group for all sessions *of all members* of the team
            def sessions = team.getSessions()
//            println "Team sessions nbr: " + sessions.size()
//            sessions.each { session ->
//                println "\tFor session $session.id, the default teams of the group are : " + session.group.defaultTeams*.id
//            }
        }
        // Calculate a statistic value for each member of the team
        members.each { player ->
            def value = 0
            if (criteria.equals('successRatio')) {
                def wins, parts
                if (sessionGroup) {
                    wins = player.getWinsBySessionGroup(sessionGroup).size()
                    parts = wins + player.getDrawsBySessionGroup(sessionGroup).size() + player.getDefeatsBySessionGroup(sessionGroup).size()
                } else {
                    wins = player.getWinsByTeam(team).size()
                    parts = wins + player.getDrawsByTeam(team).size() + player.getDefeatsByTeam(team).size()
                }
                if (parts > 0) {
                    value = wins / parts
                }
            } else if (criteria.equals('actionScore')) {
                if (sessionGroup) {
                    value = player.getActionsBySessionGroup(sessionGroup).size()
                } else {
                    value = player.getActionsByTeam(team).size()
                }
            } else if (criteria.equals('actionByRound')) {
                def actions, rounds
                if (sessionGroup) {
                    actions = player.getActionsBySessionGroup(sessionGroup).size()
                    rounds = player.getRoundsBySessionGroup(sessionGroup).size()
                } else {
                    actions = player.getActionsByTeam(team).size()
                    rounds = player.getRoundsByTeam(team).size()
                }
                if (rounds > 0) {
                    value = actions / rounds
                }
            } else if (criteria.equals('votingScore')) {
                if (sessionGroup) {
                    value = player.getVotingScoreBySessionGroup(sessionGroup)
                } else {
                    value = player.getVotingScoreByTeam(team)
                }
            } else {
                def status
                if (criteria.equals('statuses.doneGood')) {
                    status = Participation.Status.DONE_GOOD.code
                } else if (criteria.equals('statuses.doneBad')) {
                    status = Participation.Status.DONE_BAD.code
                } else if (criteria.equals('statuses.undone')) {
                    status = Participation.Status.UNDONE.code
                } else if (criteria.equals('statuses.removed')) {
                    status = Participation.Status.REMOVED.code
                }
                if (sessionGroup) {
                    value = player.getParticipationsByStatusAndSessionGroup(status, sessionGroup).size()
                } else {
                    value = player.getParticipationsByStatusAndTeam(status, team).size()
                }
            }
            def x
            if (sessionGroup) {
                x = player.getEffectiveParticipationsBySessionGroup(sessionGroup).size()
            } else {
                x = player.getEffectiveParticipationsByTeam(team).size()
            }
            if (x >= MIN_PARTS_FOR_AVERAGE_SCORING ||
                    (!criteria.equals('actionByRound') && !criteria.equals('successRatio'))) {
                memberRankingMap.put(player, value)
            }
        }
        def memberRankingSortedMap = sortMapByValue(memberRankingMap)
        return memberRankingSortedMap
    }

    // TODO redo that ugly method in Groovy
    static public Map sortMapByValue(Map map) {
        List list = new LinkedList(map.entrySet());
        Collections.sort(list, new Comparator() {
            public int compare(Object o1, Object o2) {
                return ((Comparable) ((Map.Entry) (o2)).getValue())
                        .compareTo(((Map.Entry) (o1)).getValue());
            }
        });
        Map result = new LinkedHashMap();
        for (Iterator it = list.iterator(); it.hasNext();) {
            Map.Entry entry = (Map.Entry)it.next();
            result.put(entry.getKey(), entry.getValue());
        }
        return result;
    }
}
