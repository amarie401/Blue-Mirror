class RemoveReasonFromMoods < ActiveRecord::Migration[5.0]
  def change
    remove_column :moods, :reason, :string
  end
end
