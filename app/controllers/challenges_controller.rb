class ChallengesController < ApplicationController
  def index

    @challenges = JoinChallenge.where(user_id: current_user.id)
  end
  def chat(challenge_id)
    @challenge = Challenge.find(challenge_id)
    @messages = Message.where(challenge_id: challenge_id)

  end
end
