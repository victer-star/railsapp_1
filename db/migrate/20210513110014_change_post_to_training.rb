class ChangePostToTraining < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :trainings
  end
end
