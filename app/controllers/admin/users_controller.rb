#encoding: utf-8
class Admin::UsersController < AdminController
  def index
    @users = User.order("created_at DESC").where("status = ?", ( params[:restrict] && params[:restrict] == "true" ) ? "停權" : "正常" ).all
    @user = User.new
  end

  def search
    respond_to do |format|
      if(!params[:user][:name] || params[:user][:name].length == 0)
        format.html { redirect_to admin_users_path }
      end

      @user = User.where("name like '#{params[:user][:name]}'").first

      if(@user)
  			format.html { redirect_to admin_user_path(@user.name) }
  		else
  			format.html { redirect_to admin_users_path, alert: "找不到會員：#{params[:user][:name]}" }
  		end
  	end
  end

  def show
  	@user = User.find_by_name(params[:id])
  	@user_products = @user.products.order("created_at DESC")
    @user_statusLogs = @user.statusLogs.order("created_at DESC")
  	@statusLog = StatusLog.new
  	
  end

  def restrict
    @user = User.find(params[:id])
    @statusLog = @user.statusLogs.new(params[:status_log])

    if (@user.status == "正常")
      @statusLog.status = "停權"
      @product_lock = true
    else
      @statusLog.status = "正常"
      @product_lock = false
    end

    if(@statusLog.save)
      #block all user's products
      @user.products.update_all(lock: @product_lock)
      @user.update_attribute(:status ,@statusLog.status)
    end

    respond_to do |format|
      format.html { redirect_to admin_user_path(@user.name) }
      format.js
    end
    
  end

end