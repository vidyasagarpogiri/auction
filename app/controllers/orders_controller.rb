#encoding: utf-8
class OrdersController < ApplicationController
  before_filter :find_product, :except => [:finish]

  def check
    if(params[:order][:amount] && params[:order][:amount].to_i > 0)
      @order = Order.new(params[:order])
    else
      respond_to do |format|
        flash[:alert] = "請輸入訂購數量"
        format.html { redirect_to  :back }
      end
    end
  end

  def new
    @order = Order.new(params[:order])
  end

  def create
    @order = Order.new(params[:order])
    @order.stock_id = @product.id
    @order.productname = @product.name
    @order.producttype = @product.typename
    @order.productprice = @product.price
    #訂單編號格式：訂單日期＋流水號(當日第幾筆) (YYYYMMDD0001)
    @order.ordernum = Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Order.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))
    @order.status = "新訂單"
    @order.buyer_id = current_user.id
    @order.saler_id = @product.user_id
    @order.amount = params[:order][:amount]

    respond_to do |format|
      if(@order.save)
        format.html { redirect_to  finish_orders_path }
        format.json { render json: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def find_product
    @product = Stock.where("stocks.id = ?", params[:order][:stock_id]).select("products.user_id, products.name, products.price, stocks.*").joins("left join products on products.id = stocks.product_id").first
    
  end

end