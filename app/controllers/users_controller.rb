#encoding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def products
    @products = @user.products.all
    
    respond_to do |format|
      format.html 
    end
  end

  def deals
    @deals = Deal.where("seller_id = ?", @user.id).all
    respond_to do |format|
      format.html 
    end
  end

  def find_user
    @user = User.where("id = ? OR name = ?", params[:id], params[:id]).first
  end

end