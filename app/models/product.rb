#encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :price, :amount, :region, :shippingway, :productclass_id

  validates :name, :price, :amount, :productclass_id, :presence => true, :if => :is_available
  validates :name, uniqueness: true

  before_create :generate_productnum
  before_update :check_productnum

  belongs_to :user
  belongs_to :productclass
  has_many :productasks
  has_many :productimgs, dependent: :destroy

  private
    def generate_productnum
      self.serialnum = Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Product.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))
    end

    def check_productnum
      if(!self.serialnum)
      	generate_productnum()
      end
    end

    def is_available
    	# self.status == "上架"
    	return false    	
    end
end
