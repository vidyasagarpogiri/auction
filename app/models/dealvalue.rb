class Dealvalue < ActiveRecord::Base
  attr_accessible :comment, :deal_id, :user_id, :value

  validates :comment, :deal_id, :user_id, :value, :presence => true

  belongs_to :deal
end
