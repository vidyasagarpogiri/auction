class StatusLog < ActiveRecord::Base
  attr_accessible :reason, :status, :user_id
end
