class Productregion < ActiveRecord::Base
  attr_accessible :region

  validates :region, uniqueness: true
end
