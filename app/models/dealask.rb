class Dealask < ActiveRecord::Base
  attr_accessible :content, :deal_id, :user_id

  validates :content, :deal_id, :user_id, :presence => true

  belongs_to :deal
end
