class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :serialnum
      t.string :name
      t.integer :price
      t.integer :amount
      t.text :description
      t.string :status
      t.string :cover
      t.string :region
      t.string :shippingway
      t.integer :shippingfee

      t.timestamps
    end
  end
end
