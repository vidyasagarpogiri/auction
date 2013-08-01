class Blacklist < ActiveRecord::Base
  attr_accessible :block_id, :user_id
  belongs_to :user

  validates :block_id, :user_id, :presence => true
  validates_uniqueness_of :block_id, :scope => [:user_id]
end
