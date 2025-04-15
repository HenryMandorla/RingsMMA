class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :gym_class

  validates :attended_at, presence: true
  # Optional: Ensure a user can only be marked attended once for the same class instance
  validates :user_id, uniqueness: { scope: :gym_class_id, message: "already marked attended for this class" }

  after_create :update_user_mat_hours

  private

  def update_user_mat_hours
    class_duration_hours = (gym_class.end_time - gym_class.start_time) / 3600.0
    new_total_hours = user.mat_hours + class_duration_hours
    user.update_column(:mat_hours, new_total_hours.round(1))
  end
end
