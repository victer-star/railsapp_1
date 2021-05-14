class Comment < ApplicationRecord
  belongs_to :training
  validates :user_id, presence: true
  validates :training_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
