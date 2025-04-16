class LeaderboardsController < ApplicationController
  def index
    # Update the leaderboard before displaying
    WeeklyLeaderboard.update_leaderboard
    @leaderboard = WeeklyLeaderboard.current_week
    @week_start = Date.current.beginning_of_week
  end
end 