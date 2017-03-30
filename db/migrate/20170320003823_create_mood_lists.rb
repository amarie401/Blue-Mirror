class CreateMoodLists < ActiveRecord::Migration[5.0]
  def change
    create_table :mood_lists do |t|
      t.string :moods
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
