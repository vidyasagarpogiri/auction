class Dealask < ActiveRecord::Base
  attr_accessible :content, :deal_id, :user_id

  belongs_to :deal
end
