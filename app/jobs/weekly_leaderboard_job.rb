class WeeklyLeaderboardJob < ApplicationJob
  queue_as :default

  def perform
    WeeklyLeaderboard.update_leaderboard
  end
end 