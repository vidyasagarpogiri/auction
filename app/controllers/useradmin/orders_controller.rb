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
end