class RemoveResetSentAtFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :reset_sent_at, :datetime
  end
end
