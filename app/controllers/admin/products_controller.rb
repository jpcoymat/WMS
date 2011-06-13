class Admin::ProductsController < ApplicationController

  before_filter :authorize

  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @company =  @warehouse.company
    if request.post?      
      params[:product].delete_if {|k,v| v.blank?  }
      params[:product][:company_id]  = @company.id  
      @products = Product.all(:conditions => params[:product])
    end
  end
  
  def show
    @product = Product.find(params[:product])
  end

  def edit
    @product = Product.find(params[:product])
  end
  
  def update
    @product = Product.find(params[:product][:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product updated succesfully"
      redirect_to @product
    else
      flash[:notice] = "Error updating product"
      render :action => 'edit_product'
    end
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to @product
    else
      render :action => 'add_product'
    end
  end


end
