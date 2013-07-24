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
    @product = Product.where(:status => "上架", :id => params[:id]).first
    @productask = Productask.new
    @deal = Deal.new

    if(@product)
      @product["hasType"] = (@product.stocks.first.typename != "default")
      @product["hasStock"] = hasStocks?(@product)
    end

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

  def hasStocks?(product)
    @product = product
    @product.stocks.each do |stock|
      if stock.amount
        if stock.amount > 0
          return true
        else
          next
        end
      else
        return true
      end
    end

    return false    
  end

end
