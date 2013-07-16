class Ordervalue < ActiveRecord::Base
  attr_accessible :comment, :order_id, :user_id, :value
end
