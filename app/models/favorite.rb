class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :training
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :training_id, presence: true
end
