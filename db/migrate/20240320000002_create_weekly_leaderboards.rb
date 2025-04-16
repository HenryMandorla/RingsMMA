class CreateWeeklyLeaderboards < ActiveRecord::Migration[7.1]
  def change
    create_table :weekly_leaderboards do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :mat_hours, precision: 10, scale: 2
      t.integer :rank
      t.date :week_start_date

      t.timestamps
    end

    add_index :weekly_leaderboards, [:week_start_date, :rank]
  end
end 