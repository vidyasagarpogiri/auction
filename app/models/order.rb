class Order < ActiveRecord::Base
  attr_accessible :buyer_id, :buyername, :buyertel, :ordernum, :payaccount, :paydate, :paytime, :paytype, :productname, :productprice, :saler_id, :salertel, :shippingcode, :shippingfee, :shippingway, :status, :stock_id, :amount
end
