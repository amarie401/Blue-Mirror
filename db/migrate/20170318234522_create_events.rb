class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :frequency, default: 0
      t.boolean :completed, default: :false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
