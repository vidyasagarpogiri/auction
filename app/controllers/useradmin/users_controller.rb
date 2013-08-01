#encoding: UTF-8
class Useradmin::UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def aboutme_update
  	current_user.aboutme = params[:user][:aboutme]
    current_user.accountinfo = params[:user][:accountinfo]
  	current_user.save
  	respond_to do |format|
  		format.html { redirect_to aboutme_useradmin_users_path }
        format.json { head :no_content }
    end
  end

  #create photo
  def createPhoto
    @photo = Aboutmeimg.new(params[:aboutmeimg])
    @photo.user_id = current_user.id

    respond_to do |format|
      if @photo.save
        format.json { render json: @photo, status: :created, location: @photo }
        format.js
      else
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroyPhoto
    @photo = Aboutmeimg.find(params[:id])
    @photopath = "public/uploads/aboutme/"+ @photo.user_id.to_s + "/" + @photo.id.to_s + "-" + @photo.name
    File.delete(@photopath) #carrierwave will handle this.
    @photo.destroy

    respond_to do |format|
          format.html { redirect_to :controller => 'photos', :action => 'index' }
          format.js
          format.json { head :no_content }
      end
  end

end