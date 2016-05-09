package flexygames

class VotingService {

	def vote(Session session, User voter, params) throws Exception  {
		if (!session.effectiveParticipants.contains(voter)) {
			throw new Exception("you cannot vote if you don't have participated to the session")
		}
		def existingVotes = Vote.findAllBySessionAndUser(session, voter)
		vote(session, voter, params.firstChoiceBestPlayer, 3, existingVotes)
		vote(session, voter, params.secondChoiceBestPlayer, 2, existingVotes)
		vote(session, voter, params.thirdChoiceBestPlayer, 1, existingVotes)
		vote(session, voter, params.firstChoiceWorstPlayer, -3, existingVotes)
		vote(session, voter, params.secondChoiceWorstPlayer, -2, existingVotes)
		vote(session, voter, params.thirdChoiceWorstPlayer, -1, existingVotes)
	}

	def vote(session, voter, playerName, score, existingVotes) throws Exception {
		User player
		if (playerName) {
			player = User.findByUsername(playerName)
		}
		if (voter == player) {
			throw new Exception("you cannot vote for yourself, it would be too easy ;p")
		}
		Vote existingVote = existingVotes.find{it.user == voter && it.score == score}
		if (existingVote && existingVote.player != player) {
			existingVote.delete()
		}
		if (player && player != existingVote?.player) {
			def vote = new Vote(session: session, user: voter, player: player, score: score)
			if (!vote.save()) {
				throw new Exception("error on saving a vote: " + vote.errors)
			}
		}
	}

    def voteOld(User voter, User player, Session session, String voteString) throws Exception  {
		if (voter == player) {
			throw new Exception("you cannot vote for yourself, it would be too easy ;p")
		}
		
		if (!session.effectiveParticipants.contains(voter)) {
			throw new Exception("you cannot vote if you don't have participated to the session")
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
				throw new Exception("you have already voted that")
			}
			vote.setPlayer(player)
		} else {
			vote = new Vote(session: session, user: voter, player: player, score: newScore)
		}

		if (!vote.save()) {
			throw new Exception("error on saving : " + vote.errors)
		}
    }
}
