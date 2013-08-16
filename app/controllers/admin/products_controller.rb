#encoding: UTF-8
class Admin::ProductsController < AdminController
  def index
    if(params[:query])
      params[:query] = params[:query].gsub(/[\/]+/, '')
    end

    @querystring = "products.name like '%#{params[:query]}%' OR products.serialnum = '#{params[:query]}' " 

    @products = Product.select("products.*, users.name as username").joins("INNER JOIN users ON products.user_id = users.id").where(@querystring).order("products.created_at DESC").all
    @product = Product.new

    # .where("lock = ?", ( params[:restrict] == "true" ? true : false) )
  end

  def show
  	@product = Product.select("products.*, users.name as username").joins("inner join users on users.id = products.user_id").where("products.id = ?", params[:id]).first
  	
  end

  def search
  	respond_to do |format|
      if(!params[:product][:serialnum] || params[:product][:serialnum].length == 0)
        format.html { redirect_to admin_products_path }
      end

      @product = Product.find_by_serialnum(params[:product][:serialnum])

      if(@product)
      	format.html { redirect_to admin_product_path(@product.id) }
      else
      	format.html { redirect_to admin_products_path, alert: "找不到會員：#{params[:product][:serialnum]}" }
      end
  	end
  	
  end

  def unlock
    return render :text => params[:id]
    
  end

end