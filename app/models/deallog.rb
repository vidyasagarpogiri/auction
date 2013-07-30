class Deallog < ActiveRecord::Base
  attr_accessible :deal_id, :description

  validates :deal_id, :description, :presence => true

  belongs_to :deal
end
