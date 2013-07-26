class Productaskre < ActiveRecord::Base
  attr_accessible :content, :productask_id

  validates :content, :productask_id, :presence => true

  belongs_to :productask
end
