class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :attendances
    has_many :gym_classes, through: :attendances
    has_many :forum_posts
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true # Add more validations
    validates :belt_level, inclusion: { in: %w[white blue purple brown black] }, allow_nil: true
    validate :mat_hours_above_minimum
  
    before_create :set_default_belt_level
    before_save :ensure_minimum_mat_hours, if: :belt_level_changed?
  
    HOURS_FOR_BELT = {
      'white' => { min: 0, next: 150 },
      'blue' => { min: 150, next: 500 },
      'purple' => { min: 500, next: 800 },
      'brown' => { min: 800, next: 1200 },
      'black' => { min: 1200, next: nil }
    }
  
    def mat_hours
      stored_hours = read_attribute(:mat_hours) || 0
      calculated_hours = calculate_class_hours
      [stored_hours, calculated_hours].max
    end
  
    def belt_color
      case belt_level
      when 'white'
        'bg-gray-200 text-gray-900'
      when 'blue'
        'bg-blue-600 text-white'
      when 'purple'
        'bg-purple-600 text-white'
      when 'brown'
        'bg-amber-800 text-white'
      when 'black'
        'bg-gray-900 text-white'
      else
        'bg-gray-200 text-gray-900'
      end
    end
  
    def belt_progress
      return 100.00 if belt_level == 'black'
      
      belt_info = HOURS_FOR_BELT[belt_level]
      current_hours = mat_hours
      min_hours = belt_info[:min]
      next_hours = belt_info[:next]
      
      return 0.00 if current_hours <= min_hours
      return 100.00 if current_hours >= next_hours
      
      # Calculate percentage through current belt level with two decimal places
      progress = ((current_hours - min_hours).to_f / (next_hours - min_hours) * 100).round(2)
      [progress, 100.00].min
    end
  
    private
  
    def calculate_class_hours
      total_minutes = attendances.joins(:gym_class).sum('EXTRACT(EPOCH FROM (gym_classes.end_time - gym_classes.start_time)) / 60')
      (total_minutes / 60.0).round(1)
    end
  
    def set_default_belt_level
      self.belt_level ||= 'white'
      self.mat_hours ||= 0
    end
  
    def ensure_minimum_mat_hours
      return if belt_level.nil?
      
      min_hours = HOURS_FOR_BELT[belt_level][:min]
      current_hours = read_attribute(:mat_hours) || 0
      
      if current_hours < min_hours
        self.mat_hours = min_hours
      end
    end
  
    def mat_hours_above_minimum
      return if belt_level.nil? || mat_hours.nil?
      
      min_hours = HOURS_FOR_BELT[belt_level][:min]
      if mat_hours < min_hours
        errors.add(:mat_hours, "cannot be less than #{min_hours} for #{belt_level} belt")
      end
    end
  end
  