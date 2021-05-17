class RemoveFromUserIdFromLists < ActiveRecord::Migration[5.2]
  def change
    remove_column :lists, :from_user_id, :integer
  end
end
