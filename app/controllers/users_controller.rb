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

    @querystring = "products.status = '上架' and products.name like '%#{params[:query]}%'" 
    @querystring += ( @region ? "and products.region = '#{@region}'" : "" ) 
    @querystring += ( (params[:pricemax] && params[:pricemax].length > 0) ? "and products.price <= '#{params[:pricemax]}'" : "" ) 
    @querystring += ( (params[:pricemin] && params[:pricemin].length > 0) ? "and products.price >= '#{params[:pricemin]}'" : "" )
    @querystring += ( @cate ? "and productclasses.lft >= '#{@cate.lft}' and productclasses.rgt <= '#{@cate.rgt}'" : "" ) 

    @products = @user.products.select("products.*, productclasses.lft, productclasses.rgt, productclasses.name as classname").joins("INNER JOIN productclasses ON products.productclass_id = productclasses.id").where(@querystring).order(params[:price] ? "products.price #{params[:price] == 'DESC' ? 'DESC' : 'ASC' }" : "products.created_at #{params[:create] == 'ASC' ? 'ASC' : 'DESC' }").all
    
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