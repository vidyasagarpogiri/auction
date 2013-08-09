class Admin::ProductclassesController < AdminController
  def index
    @productclasses = Productclass.order('lft ASC').all
  end

  def select
    if(params[:id].to_i == 0)
      @productclass = Productclass.new
      @children = Productclass.roots
    else
      @productclass = Productclass.find(params[:id])
      @parent = @productclass.parent
      @children = @productclass.children
    end

  	respond_to do |format|      
      format.js
    end
  	
  end

  def new
  	@productclass = Productclass.new	
  end

  def create
    @productclass = Productclass.new(params[:productclass])
    @productclass.save

    respond_to do |format|
      format.html { redirect_to admin_productclasses_path }
    end
  end

end