class Training < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lists, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :tips, length: { maximum: 50 }
  validates :description, length: { maximum: 140 }
  validate  :picture_size

  # 料理に付属するコメントのフィードを作成
  def feed_comment(training_id)
    Comment.where("training_id = ?", training_id)
  end

  private

    # アップロードされた画像のサイズを制限する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
      end
    end
end
