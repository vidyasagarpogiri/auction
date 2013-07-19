class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  belongs_to :product
end
