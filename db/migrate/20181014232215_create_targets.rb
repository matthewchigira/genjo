class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.text :name
      t.text :description
      t.integer :target_steps
      t.integer :completed_steps
      t.string :step_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
