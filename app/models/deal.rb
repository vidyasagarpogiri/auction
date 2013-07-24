class Deal < ActiveRecord::Base
  attr_accessible :amount, :buyer_id, :buyername, :buyertel, :case_id, :casename, :payaccount, :paydate, :paytime, :paytype, :seller_id, :sellertel, :serialnum, :shippingcode, :shippingfee, :shippingway, :status

  has_many :dealasks
  has_many :dealvalues
end
