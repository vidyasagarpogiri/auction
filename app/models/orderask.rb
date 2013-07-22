class Orderask < ActiveRecord::Base
  attr_accessible :content, :order_id

  belongs_to :order
end
