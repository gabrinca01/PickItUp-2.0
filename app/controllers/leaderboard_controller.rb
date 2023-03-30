class LeaderboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @leaderboard = User.order(accumulated_points: :desc).limit(15)
  end
end
