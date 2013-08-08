class Productclass < ActiveRecord::Base
	acts_as_nested_set

	has_many :products
	
	has_many :children, :class_name => 'Productclass', :foreign_key => :parent_id
	belongs_to :parent, :class_name => 'Productclass'

	accepts_nested_attributes_for :children
	attr_accessible :name, :parent_id, :children_attributes

	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => :parent_id }
end