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
end