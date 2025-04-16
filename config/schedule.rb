every :sunday, at: '12:00am' do
  runner 'WeeklyLeaderboardJob.perform_later'
end 