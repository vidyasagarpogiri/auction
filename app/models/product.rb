class Product < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :price, :amount, :region

  belongs_to :user
  has_many :productasks
  has_many :productimgs
end
