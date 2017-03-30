class RenameDateInEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :date, :from
  end
end
