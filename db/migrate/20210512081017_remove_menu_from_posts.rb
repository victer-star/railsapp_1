class RemoveMenuFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :menu, :text
  end
end
