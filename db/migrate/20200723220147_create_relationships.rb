class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    # Add indices to columns for efficiency
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # Add multiple-key index that enforces uniqueness so a user can't follow someone more than once
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
