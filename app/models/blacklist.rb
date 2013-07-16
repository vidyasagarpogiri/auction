class Blacklist < ActiveRecord::Base
  attr_accessible :block_id, :user_id
end
