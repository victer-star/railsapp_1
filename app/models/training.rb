class Training < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :tips, length: { maximum: 50 }
  validates :description, length: { maximum: 140 }
end
