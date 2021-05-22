class Like < ApplicationRecord
  belongs_to :training
  belongs_to :user
  validates_uniqueness_of :training_id, scope: :user_id
  validates :user_id, presence: true
  validates :training_id, presence: true
end
