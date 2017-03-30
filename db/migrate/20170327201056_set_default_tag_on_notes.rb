class SetDefaultTagOnNotes < ActiveRecord::Migration[5.0]
  def change
    change_column_default :notes, :tags, from: nil, to: ''
  end
end
