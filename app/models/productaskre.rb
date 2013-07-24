class Productaskre < ActiveRecord::Base
  attr_accessible :content, :productask_id

  belongs_to :productask
end
