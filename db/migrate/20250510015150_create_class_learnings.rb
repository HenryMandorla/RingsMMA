class CreateClassLearnings < ActiveRecord::Migration[8.0]
  def change
    create_table :class_learnings do |t|
      t.text :content
      t.references :gym_class, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
