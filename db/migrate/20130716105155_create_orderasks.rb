class CreateOrderasks < ActiveRecord::Migration
  def change
    create_table :orderasks do |t|
      t.integer :order_id
      t.text :content

      t.timestamps
    end
  end
end
