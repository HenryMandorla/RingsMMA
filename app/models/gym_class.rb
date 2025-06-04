class GymClass < ApplicationRecord
    has_many :attendances, dependent: :destroy
    has_many :users, through: :attendances
    has_many :class_learnings, dependent: :destroy
  
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :max_capacity, presence: true, numericality: { greater_than: 0 }
    validate :end_time_after_start_time

    private

    def end_time_after_start_time
        return if end_time.blank? || start_time.blank?
        
        if end_time <= start_time
            errors.add(:end_time, "must be after start time")
        end
    end
end