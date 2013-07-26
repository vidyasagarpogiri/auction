class Productimg < ActiveRecord::Base
  attr_accessible :path, :product_id

  validates :path, :product_id, :presence => true

  belongs_to :product
end
