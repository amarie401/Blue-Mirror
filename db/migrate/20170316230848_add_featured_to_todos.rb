class AddFeaturedToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :featured, :boolean, default: :false
  end
end
