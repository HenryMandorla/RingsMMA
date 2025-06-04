class ClassLearning < ApplicationRecord
  belongs_to :gym_class
  belongs_to :user

  validates :content, presence: true
end
