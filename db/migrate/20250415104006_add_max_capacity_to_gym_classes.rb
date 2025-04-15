class AddMaxCapacityToGymClasses < ActiveRecord::Migration[8.0]
  def change
    add_column :gym_classes, :max_capacity, :integer
  end
end
