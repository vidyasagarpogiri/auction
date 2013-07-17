#encoding: UTF-8
class ProductsController < ApplicationController
  def index
    @products = Product.where(:status => "上架").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.where(:status => "上架", :id => params[:id]).first
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

end
