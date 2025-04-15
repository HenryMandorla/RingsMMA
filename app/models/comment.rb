class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :forum_post

  validates :content, presence: true
end
