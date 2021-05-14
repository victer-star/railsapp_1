class ChangeColumnToPost < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :posts, :users
    remove_index :posts, :user_id
    remove_reference :posts, :user
  end
end
