class AddFromUserIdToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :from_user_id, :integer
  end
end
