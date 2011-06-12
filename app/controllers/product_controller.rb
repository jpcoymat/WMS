class ProductController < ApplicationController

  before_filter :authorize

  def products
    @warehouse = User.find(session[:user_id]).warehouse
    @company =  @warehouse.company
    if request.post?      
      params[:product].delete_if {|k,v| v.blank?  }
      params[:product][:company_id]  = @company.id  
      @products = Product.all(:conditions => params[:product])
    end
  end
  
  def view_product
    @product = Product.find(params[:product])
  end

  def edit_product
    @product = Product.find(params[:product])
  end
  
  def update_product
    @product = Product.find(params[:product][:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product updated succesfully"
      redirect_to @product
    else
      flash[:notice] = "Error updating product"
      render :action => 'edit_product'
    end
  end
  
  def add_product
    @product = Product.new
  end
  
  def create_product
    @product = Product.new(params[:product])
    if @product.save
      redirect_to @product
    else
      render :action => 'add_product'
    end
  end


end
