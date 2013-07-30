class Deal < ActiveRecord::Base
  attr_accessible :amount, :buyer_id, :buyername, :buyertel, :product_id, :productname, :payaccount, :paydate, :paytime, :paytype, :seller_id, :sellertel, :serialnum, :shippingcode, :shippingfee, :shippingway, :status

  validates :amount, :buyer_id, :buyername, :buyertel, :seller_id, :product_id, :productname, :status, :presence => true
  has_many :dealasks
  has_many :dealvalues
  has_many :deallogs
end
