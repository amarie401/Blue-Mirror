class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title, default: 'Untitled'
      t.text :text
      t.string :tags
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
