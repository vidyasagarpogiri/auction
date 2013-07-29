#encoding: UTF-8
class Useradmin::ProductasksController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
    if(params[:reply] == "true")
  		@productasks = current_user.productasks.where('productasks.id IN (SELECT DISTINCT(productask_id) FROM productaskres)').select("productasks.*, products.name").all
  	else
  		@productasks = current_user.productasks.where('productasks.id NOT IN (SELECT DISTINCT(productask_id) FROM productaskres)').select("productasks.*, products.name").all
  	end

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productasks }
    end  	
  end

  def show
    begin
      @productask = current_user.productasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @productask = nil
    end
  	
  	@productaskre = Productaskre.new

  	if @productask
  		@product = Product.find(@productask.product_id)
  	end

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productask }
    end
  	
  end

  def reply
  	@productaskre = Productaskre.new(params[:productaskre])
  	@productaskre.productask_id = params[:id]

  	if(@productaskre.save)
  		@productask = Productask.find(params[:id])
      respond_to do |format|
        format.html { redirect_to useradmin_productask_path(params[:id]), notice: 'Ask was successfully created.' }
        format.json { render json: @productaskre }
      end
    else
      @productask = current_user.productasks.find(params[:id])
      respond_to do |format|
        format.html { render "show" }
        format.json { render json: @productaskre }
      end
    end
  end
end