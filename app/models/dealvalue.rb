class Dealvalue < ActiveRecord::Base
  attr_accessible :comment, :deal_id, :user_id, :value

  belongs_to :deal
end
