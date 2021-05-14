class AddPictureToTrainings < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings, :picture, :string
  end
end
