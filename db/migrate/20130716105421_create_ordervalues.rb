class CreateOrdervalues < ActiveRecord::Migration
  def change
    create_table :ordervalues do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :value
      t.text :comment

      t.timestamps
    end
  end
end
