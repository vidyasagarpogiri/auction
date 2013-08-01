#encoding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def products
    if(params[:query])
      params[:query] = params[:query].gsub(/[\/]+/, '')
    end

    if(params[:region])
      begin
        @region = Productregion.find(params[:region]).region
      rescue
        params[:region] = nil
      end
    end

    @querystring = "status = '上架' and name like '%#{params[:query]}%'" + ( @region ? "and region = '#{@region}'" : "" ) + ( (params[:pricemax] && params[:pricemax].length > 0) ? "and price <= '#{params[:pricemax]}'" : "" ) + ( (params[:pricemin] && params[:pricemin].length > 0) ? "and price >= '#{params[:pricemin]}'" : "" )

    if(params[:price])
      @products = @user.products.where(@querystring).order("price #{params[:price] == 'DESC' ? 'DESC' : 'ASC' }").all
    else
      @products = @user.products.where(@querystring).order("created_at #{params[:create] == 'ASC' ? 'ASC' : 'DESC' }").all
    end
    
    respond_to do |format|
      format.html 
    end
  end

  def deals
    @deals = Deal.where("seller_id = ?", @user.id).all
    respond_to do |format|
      format.html 
    end
  end

  def find_user
    @user = User.where("id = ? OR name = ?", params[:id], params[:id]).first
  end

end