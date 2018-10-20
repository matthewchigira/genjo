class AddDeletionDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :deletion_digest, :string
  end
end
