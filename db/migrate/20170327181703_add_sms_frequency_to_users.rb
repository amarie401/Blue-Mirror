class AddSmsFrequencyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sms_frequency, :string
  end
end
