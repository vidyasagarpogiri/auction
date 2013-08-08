class Admin::ProductclassesController < AdminController
  def index
    @productclasses = Productclass.all
  end

end