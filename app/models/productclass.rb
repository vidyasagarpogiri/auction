class Productclass < ActiveRecord::Base
  attr_accessible :name, :parent_class
  
  validates :name, :parent_class, :presence => true
end
