class Productimg < ActiveRecord::Base
  attr_accessible :path, :product_id

  belongs_to :product
end
