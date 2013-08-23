#encoding: UTF-8
class Useradmin::MessagesController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"

  def index
    @queryProductasks = "SELECT productasks.id, productasks.created_at, 'productask' as type, '商品發問' as class, null as dealstatus, products.name as productname, null as username, null as ordernum, productasks.isread FROM productasks INNER JOIN products ON productasks.product_id = products.id WHERE products.user_id = " + current_user.id.to_s
    @queryDeals = "SELECT deals.id, deals.created_at, 'deal' as type, '新交易' as class, null as dealstatus, deals.productname, users.name as username, deals.serialnum as ordernum, deals.isread FROM deals INNER JOIN users ON deals.buyer_id = users.id WHERE deals.seller_id = " + current_user.id.to_s
    @queryDealasks = "SELECT deals.id, dealasks.created_at, 'dealask' as type, '交易訊息' as class, null as dealstatus, null as productname, null as username, deals.serialnum as ordernum, dealasks.isread FROM dealasks INNER JOIN deals ON dealasks.deal_id = deals.id WHERE deals.seller_id = " + current_user.id.to_s + " AND NOT dealasks.user_id = " + current_user.id.to_s
    @queryDealvalues = "SELECT deals.id, dealvalues.created_at, 'dealvalue' as type, '交易評價' as class, null as dealstatus, null as productname, null as username, deals.serialnum as ordernum, dealvalues.isread FROM dealvalues INNER JOIN deals ON dealvalues.deal_id = deals.id WHERE deals.seller_id = " + current_user.id.to_s + " AND NOT dealvalues.user_id = " + current_user.id.to_s
    @queryMyasks = "SELECT productasks.id, productaskres.created_at, 'myask' as type, '發問回覆' as class, null as dealstatus, products.name as productname, null as username, null as ordernum, productaskres.isread FROM productaskres INNER JOIN productasks ON productaskres.productask_id = productasks.id  INNER JOIN products ON productasks.product_id = products.id WHERE productasks.user_id = " + current_user.id.to_s
    @queryDeallogs = "SELECT deals.id, deallogs.created_at, 'deallog' as type, '交易狀態' as class, deals.status as dealstatus, null as productname, null as username, deals.serialnum as ordernum, deallogs.isread FROM deallogs INNER JOIN deals ON deallogs.deal_id = deals.id WHERE deals.buyer_id = " + current_user.id.to_s

    @msgs = ActiveRecord::Base.connection.select_all("SELECT * FROM ( #{@queryProductasks} UNION ALL #{@queryDeals} UNION ALL #{@queryDealasks} UNION ALL #{@queryDealvalues} UNION ALL #{@queryMyasks} UNION ALL #{@queryDeallogs} ) results WHERE isread = #{ (params[:isread] == 'true') ? "'true'" : "'false'" } ORDER BY created_at DESC")
  end

  def checked
    case (params[:type])
      when "productask"
        @message = Productask.find(params[:id])
        @redirect_path = useradmin_productask_path(params[:id])

      when "deal"
        @message = Deal.find(params[:id])
        @redirect_path = useradmin_deal_path(params[:id])
        
      when "dealask"
        @message = Dealask.find(params[:id])
        @redirect_path = useradmin_deal_path(params[:id])
        
      when "dealvalue"
        @message = Dealvalue.find(params[:id])
        @redirect_path = dealvalues_useradmin_deal_path(params[:id])
        
      when "myask"
        @message = Dealaskre.find(params[:id])
        @redirect_path = useradmin_myask_path(params[:id])
        
      when "deallog"
        @message = Deallog.find(params[:id])
        @redirect_path = useradmin_deal_path(params[:id])

      else
        @redirect_path = useradmin_messages_path
        
    end

    respond_to do |format|
      if(@message)
        @message.isread = "true"
        @message.save
      end

      format.html { redirect_to @redirect_path }
    end
    
  end

end