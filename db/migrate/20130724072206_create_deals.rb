class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :product_id
      t.string :serialnum
      t.string :productname
      t.integer :amount
      t.integer :shippingfee
      t.string :shippingway
      t.string :shippingcode
      t.date :paydate
      t.string :paytime
      t.string :payaccount
      t.string :paytype
      t.string :status
      t.integer :buyer_id
      t.string :buyertel
      t.string :buyername
      t.integer :seller_id
      t.string :sellertel

      t.timestamps
    end
  end
end
