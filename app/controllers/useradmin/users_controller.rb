#encoding: UTF-8
class Useradmin::UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def aboutme_update
  	current_user.aboutme = params[:user][:aboutme]
  	current_user.save
  	respond_to do |format|
  		format.html { redirect_to aboutme_useradmin_users_path }
        format.json { head :no_content }
    end
  end

end