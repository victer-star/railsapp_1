class Record < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :menu, presence: true, length: { maximum: 15 }
end
