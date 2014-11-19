package flexygames

class VotingService {

    def vote(User voter, User player, Session session, String voteString) throws Exception  {
		if (voter == player) {
			throw new Exception("You cannot vote for yourself, it would be too easy !!")
		}
		
		if (!session.effectiveParticipants.contains(voter)) {
			throw new Exception("You cannot vote if you don't have participated to the session !!")
		}

		def newScore = 0
		if (voteString == "firstPositive") {
			newScore = 3;
		} else  if (voteString == "secondPositive") {
			newScore = 2;
		} else  if (voteString == "thirdPositive") {
			newScore = 1;
		} else  if (voteString == "firstNegative") {
			newScore = -3;
		} else  if (voteString == "secondNegative") {
			newScore = -2;
		} else  if (voteString == "thirdNegative") {
			newScore = -1;
		}

		def vote = null
		def existingVotes = Vote.findAllBySessionAndUser(session, voter)
		existingVotes.each { v ->
			if (v.score == newScore) {
				vote = v
			}
		}
		if (vote) {
			if (vote.player == player) {
				throw new Exception("You have already voted that !!")
			}
			vote.setPlayer(player)
		} else {
			vote = new Vote(session: session, user: voter, player: player, score: newScore)
		}

		if (!vote.save()) {
			throw new Exception("Error on saving : " + vote.errors)
		}
    }
}
