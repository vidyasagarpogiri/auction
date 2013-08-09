class Admin::ProductclassesController < AdminController
  def index
    @productclasses = Productclass.order('lft ASC').all
  end

  def show
    if(params[:id] != "root")
      @productclass = Productclass.find(params[:id])
    end
    
  end

  def new
  	@productclass = Productclass.new	
  end

  def addsub
    if(params[:id].to_i > 0)
      @parent = Productclass.find(params[:id])
    end
    @productclass = Productclass.new
  end

  def create
    @productclass = Productclass.new(params[:productclass])
    @productclass.save

    respond_to do |format|
      format.html { redirect_to admin_productclasses_path }
    end
  end

  def edit
    @productclass = Productclass.find(params[:id])
    @productclasses = Productclass.where("lft < ? OR rgt > ?", @productclass.parent ? @productclass.parent.lft : @productclass.lft, @productclass.parent ? @productclass.parent.rgt : @productclass.rgt).order('lft ASC').all
    
  end

  def update
    @productclass = Productclass.find(params[:id])
    
    if(params[:productclass][:parent_id] == "0")
      params[:productclass].delete(:parent_id)
    end

    respond_to do |format|
      if @productclass.update_attributes(params[:productclass])
        format.html { redirect_to admin_productclasses_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @productclass.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @productclass = Productclass.find(params[:id])
    @productclass.destroy
    respond_to do |format|
      format.html { redirect_to admin_productclasses_path }
    end
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

end