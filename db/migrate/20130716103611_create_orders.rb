class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :stock_id
      t.string :productname
      t.string :producttype
      t.integer :productprice
      t.integer :amount
      t.integer :shippingfee
      t.string :shippingway
      t.string :shippingcode
      t.string :ordernum
      t.date :paydate
      t.string :paytime
      t.string :payaccount
      t.string :paytype
      t.string :status
      t.integer :buyer_id
      t.string :buyertel
      t.string :buyername
      t.integer :saler_id
      t.string :salertel

      t.timestamps
    end
  end
end
