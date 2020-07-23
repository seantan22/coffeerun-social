class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :item
      t.string :details
      t.string :vendor
      t.string :size
      t.string :zone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :orders, [:user_id, :created_at]
  end
end
