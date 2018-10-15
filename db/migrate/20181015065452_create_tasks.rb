class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :name
      t.text :description
      t.date :due_date
      t.boolean :is_high_priority
      t.boolean :is_complete
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tasks, [:due_date, :is_complete]  
  end
end
