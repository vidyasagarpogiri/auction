class Productimg < ActiveRecord::Base
  attr_accessible :path, :product_id, :image, :name

  validates :image, :name, :product_id, :presence => true

  belongs_to :product

  mount_uploader :image, ProductUploader
  
  before_create :update_filename
  #validates_uniqueness_of :name, :on => :create
  
  private
  def update_filename
  	self.name = image.file.filename
  end
end
