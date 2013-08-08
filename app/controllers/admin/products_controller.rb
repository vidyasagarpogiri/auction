#encoding: UTF-8
class Admin::ProductsController < AdminController
  def index
    @products = Product.select("products.id, products.created_at, products.cover, products.name, products.price, products.region, users.name as username").joins("INNER JOIN users ON products.user_id = users.id").order("products.created_at DESC").all
  end

end