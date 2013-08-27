#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :tel, :name, :aboutme, :accountinfo

  validates :tel, :name, :presence => true
  validates :name, uniqueness: true
  validates :name, format: { with: /^[\w]+$/, message: "只能包含英文字母數字與下底線" }

  has_many :products
  has_many :productasks, :through => :products
  has_many :blacklists
  has_many :aboutmeimgs
  has_many :statusLogs
end
