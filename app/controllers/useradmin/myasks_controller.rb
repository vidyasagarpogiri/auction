#encoding: UTF-8
class Useradmin::MyasksController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
  	@myasks = Productask.joins("left join products on  products.id = productasks.product_id").select("products.name, productasks.*").where("productasks.user_id = ?", current_user.id).all

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @myasks }
    end  	
  end
end