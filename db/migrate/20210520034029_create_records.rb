class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :user_id
      t.string :menu
      t.integer :set
      t.integer :weight
      t.integer :rep
      t.datetime :start_time

      t.timestamps
    end
    add_index :records, :user_id
  end
end
