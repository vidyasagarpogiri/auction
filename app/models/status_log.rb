class StatusLog < ActiveRecord::Base
  attr_accessible :reason, :status, :user_id
  validates :reason, :status, :user_id, :presence => true
end
