class Product < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :price, :region

  belongs_to :user
end
