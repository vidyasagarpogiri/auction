class Admin < ActiveRecord::Base
	attr_accessible :email, :username, :password

	validates :email, :username, :password, :presence => true
	validates_uniqueness_of :email

	before_save :encrypt_psw

	def encrypt_psw
		self.password = Digest::SHA1.hexdigest(self.password)
	end
end
