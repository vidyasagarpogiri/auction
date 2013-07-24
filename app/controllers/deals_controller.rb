#encoding: utf-8
class DealsController < ApplicationController
  before_filter :find_product, :except => [:finish]

  def check
    if(params[:deal][:amount] && params[:deal][:amount].to_i > 0)
      @deal = Deal.new(params[:deal])
    else
      respond_to do |format|
        flash[:alert] = "請輸入訂購數量"
        format.html { redirect_to  :back }
      end
    end
  end

  def new
    @deal = Deal.new(params[:deal])
  end

  def create
    @deal = Deal.new(params[:deal])
    @deal.product_id = @product.id
    @deal.productname = @product.name
    
    #訂單編號格式：訂單日期＋流水號(當日第幾筆) (YYYYMMDD0001)
    @deal.serialnum = Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Deal.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))
    @deal.status = "新訂單"
    @deal.buyer_id = current_user.id
    @deal.seller_id = @product.user_id
    @deal.amount = params[:deal][:amount]

    respond_to do |format|
      if(@deal.save)
        format.html { redirect_to  finish_deals_path }
        format.json { render json: @deal }
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def find_product
    @product = Product.find(params[:deal][:product_id])
    
  end

end