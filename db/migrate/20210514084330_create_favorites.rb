class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :training_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :training_id], unique: true
  end
end
