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

    respond_to do |format|
      format.html { redirect_to dealvalues_useradmin_buyrecord_path(params[:id]) }
      format.json { render json: @dealvalue }
    end 
  end

  def count_buyrecords
    @countnew = Deal.where("buyer_id = ? AND status = ?", current_user.id, "new").count
    @countcheck = Deal.where("buyer_id = ? AND status = ?", current_user.id, "check").count
    @countprocessing = Deal.where("buyer_id = ? AND status = ?", current_user.id, "processing").count
    @countdeliver = Deal.where("buyer_id = ? AND status = ?", current_user.id, "deliver").count
    @countcancel = Deal.where("buyer_id = ? AND status = ?", current_user.id, "cancel").count
  end
end