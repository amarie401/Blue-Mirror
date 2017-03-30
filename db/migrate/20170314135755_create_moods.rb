class CreateMoods < ActiveRecord::Migration[5.0]
  def change
    create_table :moods do |t|
      t.integer :mood
      t.string :reason
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
