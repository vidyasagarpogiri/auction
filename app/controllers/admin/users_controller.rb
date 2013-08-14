#encoding: utf-8
class Admin::UsersController < AdminController
  def index
    @users = User.order("created_at DESC").all
    @user = User.new
  end

  def search
  	@user = User.where("name like '%#{params[:user][:name]}%'").first

  	respond_to do |format|
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
      @product_new_status = "鎖定"
    else
      @statusLog.status = "正常"
      @product_new_status = "上架"
    end

    if(@statusLog.save)
      #block all user's products
      @user.products.update_all(status: @product_new_status)
      @user.update_attribute(:status ,@statusLog.status)
    end

    respond_to do |format|
      format.html { redirect_to admin_user_path(@user.name) }
    end
    
  end

end