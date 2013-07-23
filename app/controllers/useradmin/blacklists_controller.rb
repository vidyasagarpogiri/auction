#encoding: UTF-8
class Useradmin::BlacklistsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@blacklists = current_user.blacklists.all
  	@blacklist = Blacklist.new
  end

  def create
  	@blacklist = current_user.blacklists.new(params[:blacklist])
  	@blacklist.save

  	respond_to do |format|
  		format.html { redirect_to useradmin_blacklists_path }
    end
  	
  end

  def destroy
  	@blacklist = Blacklist.find(params[:id])
  	@blacklist.destroy

  	respond_to do |format|
  		format.html { redirect_to useradmin_blacklists_path }
    end  	
  end
end