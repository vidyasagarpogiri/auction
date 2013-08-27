#encoding: UTF-8 
class Useradmin::Changestatus::DealsController < ApplicationController
	before_filter :find_deal

  def check
    if(@deal.status == "new" )
    	@deal.status = "check"
    	@deal.save

      logstatus_mail(@deal, "已收款")
    end

    respond_to do |format|
      format.html { redirect_to useradmin_deal_path(@deal) }
      format.json { render json: @deal }
    end
    
  end

  def processing
  	if((@deal.status == "check" && @deal.paytype == "匯款" ) || (@deal.status == "new" && @deal.paytype != "匯款" ))
    	@deal.status = "processing"
    	@deal.save

      logstatus_mail(@deal, "處理中")
    end

    respond_to do |format|
      format.html { redirect_to useradmin_deal_path(@deal) }
      format.json { render json: @deal }
    end
    
  end

  def deliver
  	if(@deal.status == "processing" && params[:deal][:shippingway].length>0 && params[:deal][:shippingcode].length>0)
  		@deal.shippingway = params[:deal][:shippingway]
  		@deal.shippingcode = params[:deal][:shippingcode]
    	@deal.status = "deliver"
    	@deal.save

      logstatus_mail(@deal, "已出貨")

    	respond_to do |format|
    		format.html { redirect_to useradmin_deal_path(@deal) }
    		format.json { render json: @deal }
    	end

    else
    	respond_to do |format|
    		format.html { redirect_to useradmin_deal_path(@deal), alert: '請填寫運送方式及追蹤碼。' }
    		format.json { render json: @deal }
    	end
    end

  end

  def cancel
  	@deal.status = "cancel"
  	@deal.save

    logstatus_mail(@deal, "已取消")

  	respond_to do |format|
      format.html { redirect_to useradmin_deal_path(@deal) }
      format.json { render json: @deal }
    end    
  end

  def logstatus_mail(deal, status)
    @deal = deal
    @deallog = @deal.deallogs.new
    @deallog.description = "訂單變更狀態為：" + status
    @deallog.save

    Sendmail.deal_status_change(@deal.buyeremail, @deal)
  end
  
  def find_deal
  	@deal = Deal.select("deal.*, users.email as buyeremail").joins("INNER JOIN users ON deal.buyer_id = users.id").find(params[:deal_id])  	
  end
end