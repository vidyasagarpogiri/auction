class Blacklist < ActiveRecord::Base
  attr_accessible :block_id, :user_id
  belongs_to :user

  validates :block_id, :user_id, :presence => true
end
