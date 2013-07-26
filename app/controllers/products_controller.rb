#encoding: UTF-8
class ProductsController < ApplicationController
  def index
    @products = Product.where(:status => "上架").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.where(:status => "上架", :id => params[:id]).select("products.*, users.name as username").joins("left join users on users.id = products.user_id").first
    @productask = Productask.new
    @deal = Deal.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def ask
    @productask = Productask.new(params[:productask])
    @productask.product_id = params[:id]
    @productask.user_id = current_user.id

    if(@productask.save)
      respond_to do |format|
        format.html { redirect_to product_path(params[:id]), notice: 'Ask was successfully created.' }
        format.json { render json: @productask }
      end
    else
      @product = product.where(:status => "上架", :id => params[:id]).first
      respond_to do |format|
        format.html { render "show" }
        format.json { render json: @productask }
      end
    end
    
  end

end