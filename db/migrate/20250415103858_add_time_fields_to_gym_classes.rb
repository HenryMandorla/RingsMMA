class AddTimeFieldsToGymClasses < ActiveRecord::Migration[8.0]
  def change
    add_column :gym_classes, :start_time, :datetime
    add_column :gym_classes, :end_time, :datetime
  end
end
