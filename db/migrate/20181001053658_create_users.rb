class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.string :reset_digest
      t.boolean :activated, default: false
      t.boolean :admin, default: false
      t.boolean :private, default: false
      t.datetime :reset_sent_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
