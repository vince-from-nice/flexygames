package flexygames

import grails.gorm.transactions.Transactional

@Transactional
class TeamStatsService {

    def getTeamMembersRanking(Team team, String criteria, SessionGroup sessionGroup) {
        TreeMap<User, Number> memberRankingMap = new TreeMap<User, Number>()

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
            // Check if member is eligible in first to avoid useless computing
            if (isMemberEligibleToRanking(team, player, criteria, sessionGroup)) {
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
                } else if (criteria.equals('statuses.present')) {
                    def statusCodes = [Participation.Status.DONE_GOOD.code, Participation.Status.DONE_BAD.code, Participation.Status.DONE_LATE.code]
                    if (sessionGroup) {
                        value = player.getParticipationsByStatusAndSessionGroup(statusCodes, sessionGroup).size()
                    } else {
                        value = player.getParticipationsByStatusAndTeam(statusCodes, team).size()
                    }
                } else if (criteria.startsWith('statuses.')) {
                    def status
                    if (criteria.equals('statuses.doneGood')) {
                        status = Participation.Status.DONE_GOOD.code
                    } else if (criteria.equals('statuses.doneBad')) {
                        status = Participation.Status.DONE_BAD.code
                    } else if (criteria.equals('statuses.doneLate')) {
                        status = Participation.Status.DONE_LATE.code
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
                memberRankingMap.put(player, value)
            }
        }

        // Handle tasks ranking in another way
        if (criteria.startsWith('tasks.')) {
            TaskType taskType = TaskType.findByCode(criteria.substring('tasks.'.length()))
            def allTasks = Task.findAllByType(taskType)
            def teamSessionGroupIds = team.sessionGroups*.id
            def value = 0
            members.each { player ->
                def tasks = allTasks.grep{it.user == player}
                if (sessionGroup) {
                    tasks = tasks.grep{it.session.group == sessionGroup}
                } else {
                    tasks = tasks.grep{teamSessionGroupIds.contains(it.session.group.id)}
                }
                memberRankingMap.put(player, tasks.size())
            }
        }

        def memberRankingSortedMap = sortMapByValue(memberRankingMap)
        return memberRankingSortedMap
    }

    def isMemberEligibleToRanking(Team team, User player, String criteria, SessionGroup sessionGroup) {
        def MIN_PARTS_FOR_AVERAGE_SCORING = 10
        if (criteria.equals('actionByRound') && criteria.equals('successRatio')) {
            def x
            if (sessionGroup) {
                x = player.getEffectiveParticipationsBySessionGroup(sessionGroup).size()
            } else {
                x = player.getEffectiveParticipationsByTeam(team).size()
            }
            return x >= MIN_PARTS_FOR_AVERAGE_SCORING
        }
        return true
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
