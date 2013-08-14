class StatusLog < ActiveRecord::Base
  attr_accessible :reason
  validates :reason, :status, :user_id, :presence => true

  belongs_to :user
end
