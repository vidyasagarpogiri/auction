#encoding: UTF-8
class ProductsController < ApplicationController
  def index
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

    if(params[:cate])
      begin
        @cate = Productclass.find(params[:cate])
      rescue
        params[:cate] = nil
        @root_cates = Productclass.roots
      end
    else
      @root_cates = Productclass.roots
    end

    @querystring = "products.status = '上架' and products.name like '%#{params[:query]}%'" 
    @querystring += ( @region ? "and products.region = '#{@region}'" : "" ) 
    @querystring += ( (params[:pricemax] && params[:pricemax].length > 0) ? "and products.price <= '#{params[:pricemax]}'" : "" ) 
    @querystring += ( (params[:pricemin] && params[:pricemin].length > 0) ? "and products.price >= '#{params[:pricemin]}'" : "" )
    @querystring += ( @cate ? "and productclasses.lft >= '#{@cate.lft}' and productclasses.rgt <= '#{@cate.rgt}'" : "" ) 

    @products = Product.select("products.*, productclasses.lft, productclasses.rgt, productclasses.name as classname").joins("INNER JOIN productclasses ON products.productclass_id = productclasses.id").where(@querystring).order(params[:price] ? "products.price #{params[:price] == 'DESC' ? 'DESC' : 'ASC' }" : "products.created_at #{params[:create] == 'ASC' ? 'ASC' : 'DESC' }").all
    
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

    @product = Product.where(:status => "上架", :id => params[:id]).select("products.*, users.name as username").joins("left join users on users.id = products.user_id").first

    if(@product.user_id != current_user.id && @productask.save)
      respond_to do |format|
        format.html { redirect_to product_path(params[:id]), notice: 'Ask was successfully created.' }
        format.json { render json: @productask }
      end
    elsif @product.user_id == current_user.id
      respond_to do |format|
        format.html { redirect_to product_path(params[:id]), alert: '您無法對自己的商品發問。' }
        format.json { render json: @productask }
      end        
    else
      @deal = Deal.new
      respond_to do |format|
        format.html { render "show" }
        format.json { render json: @productask.errors }
      end
    end
  end

end