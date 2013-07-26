class Productask < ActiveRecord::Base
  attr_accessible :content, :product_id, :user_id

  validates :content, :product_id, :user_id, :presence => true

  belongs_to :user
  belongs_to :product

  has_many :productaskres
end
