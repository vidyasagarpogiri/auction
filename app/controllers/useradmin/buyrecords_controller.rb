#encoding: UTF-8
class Useradmin::BuyrecordsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@buyrecords = Order.where("buyer_id = ?", current_user.id).all

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buyrecords }
    end  	
  end

  def show
  	@order = Order.where("buyer_id = ? and id = ?", current_user.id, params[:id]).first
  	@orderask = Orderask.new  	
  end

  def createask
  	@orderask = Orderask.new(params[:orderask])
    @orderask.user_id = current_user.id
  	@orderask.order_id = params[:id]
  	@orderask.save

  	respond_to do |format|
      format.html { redirect_to useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @orderask }
    end 
  end
end