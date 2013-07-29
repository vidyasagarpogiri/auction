#encoding: UTF-8
class Useradmin::ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout "useradmin"
  
  def index
    @products = current_user.products.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = current_user.products.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.status = "上架"
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_useradmin_product_path(@product), :notice => 'Product was successfully created.' }
        format.json {  render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to useradmin_product_path(@product), notice: 'product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to useradmin_products_path }
      format.json { head :no_content }
    end
  end

  #create photo
  def createPhoto
    @photo = Productimg.new(params[:productimg])
    @photo.product_id = params[:id]

    respond_to do |format|
      if @photo.save
        format.json { render json: @photo, status: :created, location: @photo }
        format.js
      else
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroyPhoto
    @photo = Productimg.find(params[:photo_id])
    @photopath = "public/uploads/products/"+ @photo.product_id.to_s + "/" + @photo.id.to_s + "-" + @photo.name
    File.delete(@photopath) #carrierwave will handle this.
    @photo.destroy

    respond_to do |format|
          format.html { redirect_to :controller => 'photos', :action => 'index' }
          format.js
          format.json { head :no_content }
      end
  end
end
