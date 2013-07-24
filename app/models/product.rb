class Product < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :price, :region

  belongs_to :user
  has_many :stocks
  has_many :productasks
  has_many :productimgs
end
