class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.date :date
      t.text :title
      t.text :entry
      t.references :user, foreign_key: true

      t.timestamps
    end
  add_index :diaries, [:user_id, :created_at] 
  end
end
