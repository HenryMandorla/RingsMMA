class WeeklyLeaderboard < ApplicationRecord
  belongs_to :user

  validates :mat_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rank, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :week_start_date, presence: true

  def self.current_week
    current_week = Date.current.beginning_of_week
    existing_leaderboard = where(week_start_date: current_week)
    
    if existing_leaderboard.empty?
      update_leaderboard
    end
    
    # Always return the current week's leaderboard, ordered by rank
    where(week_start_date: current_week).order(:rank)
  end

  def self.update_leaderboard
    current_week = Date.current.beginning_of_week
    
    # Delete existing entries for current week
    where(week_start_date: current_week).delete_all
    
    # Get all users and their weekly mat hours
    users_with_hours = User.all.map do |user|
      [user, user.weekly_mat_hours(current_week)]
    end

    # Sort by hours and take top 10
    top_users = users_with_hours
      .sort_by { |user, hours| -hours }
      .first(10)
    
    # Create new leaderboard entries
    top_users.each_with_index do |user_data, index|
      user, hours = user_data
      create!(
        user: user,
        mat_hours: hours,
        rank: index + 1,
        week_start_date: current_week
      )
    end
  end
end 