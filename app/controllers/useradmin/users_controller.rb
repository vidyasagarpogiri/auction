#encoding: UTF-8
class Useradmin::UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def aboutme
  	
  end
end