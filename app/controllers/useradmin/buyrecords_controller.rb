#encoding: UTF-8
class Useradmin::BuyrecordsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :count_buyrecords, :only => [:index, :show]
  layout "useradmin"

  def index
  	case params[:type]
    when "new", "check", "processing", "deliver", "cancel"
      #do nothing
    else
      params[:type] = "new"
    end

    @buyrecords = Deal.where("buyer_id = ? AND status = ?", current_user.id, params[:type]).order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buyrecords }
    end  	
  end

  def show
  	@deal = Deal.where("buyer_id = ? and id = ?", current_user.id, params[:id]).first
  	@deal_value = @deal.dealvalues.select("dealvalues.*").where("dealvalues.user_id = ?", @deal.buyer_id).last
    @dealask = Dealask.new  	
  end

  def createask
  	@dealask = Dealask.new(params[:dealask])
    @dealask.user_id = current_user.id
  	@dealask.deal_id = params[:id]
  	@dealask.save

    #send mail to seller
    @deal = Deal.select("deals.serialnum, users.email as usermail, users.name as username").joins("INNER JOIN users ON deals.seller_id = users.id").find(params[:id])
    Sendmail.dealvalue_new(@deal, @dealask).deliver

  	respond_to do |format|
      format.html { redirect_to useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @dealask }
    end 
  end

  def dealvalues
    @deal = Deal.where("buyer_id = ? and id = ?", current_user.id, params[:id]).first
    @deal_value = @deal.dealvalues.select("dealvalues.*").where("dealvalues.user_id = ?", @deal.buyer_id).last
    @dealvalue = Dealvalue.new
  end

  def createvalue
    @dealvalue = Dealvalue.new(params[:dealvalue])
    @dealvalue.user_id = current_user.id
    @dealvalue.deal_id = params[:id]
    @dealvalue.save

    #send mail to seller
    @deal = Deal.select("deals.serialnum, users.email as usermail, users.name as username").joins("INNER JOIN users ON deals.seller_id = users.id").find(params[:id])
    Sendmail.dealvalue_new(@deal, @productvalue).deliver

    respond_to do |format|
      format.html { redirect_to dealvalues_useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @dealvalue }
    end 
  end

  def count_buyrecords
    @deals = Deal.where("buyer_id = ?", current_user.id).all

    @countnew = 0
    @countcheck = 0
    @countprocessing = 0
    @countdeliver = 0
    @countcancel = 0
    
    @deals.each do |deal|
      case deal.status
        when "new"
          @countnew++
        when "check"
          @countcheck++
        when "processing"
          @countprocessing++
        when "deliver"
          @countdeliver++
        when "cancel"
          @countcancel++
      end
        
    end
  end
end