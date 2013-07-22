#encoding: UTF-8
class Useradmin::OrdersController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@orders = Order.where("saler_id = ?", current_user.id).all

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end  	
  end

  def show
  	@order = Order.where("saler_id = ? and id = ?", current_user.id, params[:id]).first
  	@orderask = Orderask.new  	
  end

  def createask
  	@orderask = Orderask.new(params[:orderask])
    @orderask.user_id = current_user.id
  	@orderask.order_id = params[:id]
  	@orderask.save

  	respond_to do |format|
      format.html { redirect_to useradmin_order_path(params[:id]) }
      format.json { render json: @orderask }
    end 
  end

  def ordervalues
    @order = Order.where("saler_id = ? and id = ?", current_user.id, params[:id]).first
    @ordervalue = Ordervalue.new
  end

  def createvalue
    @ordervalue = Ordervalue.new(params[:ordervalue])
    @ordervalue.user_id = current_user.id
    @ordervalue.order_id = params[:id]
    @ordervalue.save

    respond_to do |format|
      format.html { redirect_to ordervalues_useradmin_order_path(params[:id]) }
      format.json { render json: @ordervalue }
    end 
  end
end