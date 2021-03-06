class Admin::ProductsController < ApplicationController

  before_filter :authorize

  def lookup
    @warehouse = User.find(session[:user_id]).warehouse
    @company =  @warehouse.company
    if request.post?      
      params[:product].delete_if {|k,v| v.blank?  }
      params[:product][:company_id]  = @company.id  
      @products = Product.all(:conditions => params[:product])
    end
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @company = User.find(session[:user_id]).company
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
    @suppliers =  @company.suppliers 
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product updated succesfully"
      redirect_to admin_product_path(@product)
    else
      @company = User.find(session[:user_id]).company
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      @suppliers =  @company.suppliers 
      flash[:notice] = "Error updating product"
      render :action => 'edit'
    end
  end
  
  def new
    @product = Product.new
    @company = User.find(session[:user_id]).company
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
    @suppliers =  @company.suppliers 
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_product_path(@product)
    else
      @company = User.find(session[:user_id]).company
      @product_categories = @company.product_categories
      @product_subcategories = @company.product_subcategories
      @suppliers =  @company.suppliers 
      render :action => 'new'
    end
  end


end
