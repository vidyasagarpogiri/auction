class Aboutmeimg < ActiveRecord::Base
  attr_accessible :image, :user_id, :name

  belongs_to :user
  
  mount_uploader :image, AboutmeUploader
  
  before_create :update_filename
  #validates_uniqueness_of :name, :on => :create
  
  private
  def update_filename
  	self.name = image.file.filename
  end
end
