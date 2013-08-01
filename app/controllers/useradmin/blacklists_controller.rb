#encoding: UTF-8
class Useradmin::BlacklistsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@blacklists = current_user.blacklists.all
  	@blacklist = Blacklist.new
  end

  def create
    @user = User.where("name = ?", params[:blacklist][:block_id]).first
    if(@user)
    	@blacklist = current_user.blacklists.new(params[:blacklist])
      @blacklist.block_id = @user.id
      @blacklist.block_name = @user.name
    	@blacklist.save

    	respond_to do |format|
    		format.html { redirect_to useradmin_blacklists_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to useradmin_blacklists_path, alert: '使用者不存在。' }
      end
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