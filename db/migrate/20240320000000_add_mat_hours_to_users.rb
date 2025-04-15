class AddMatHoursToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mat_hours, :decimal, precision: 10, scale: 1, default: 0
  end
end 