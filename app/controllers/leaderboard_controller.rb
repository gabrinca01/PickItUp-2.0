class LeaderboardController < ApplicationController
  def index
    @leaderboard = User.order(accumulated_points: :desc).limit(15)
  end
end
