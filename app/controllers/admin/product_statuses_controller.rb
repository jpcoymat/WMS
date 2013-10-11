class Admin::ProductStatusesController < ApplicationController
    
  
  def index
    @company = current_user.company
    @product_statuses = ProductStatus.all
    @product_status = ProductStatus.new
  end
  
  def create
    @product_status = ProductStatus.new(params[:product_status])
    if @product_status.save
      flash[:notice] = "Product Status created succesfully"
    else
      flash[:notice] = "Error creating product status"
    end
    redirect_to admin_product_statuses_path
  end
  
  def edit
    @product_status = ProductStatus.find(params[:id])
  end
  
  def update
    @product_status = ProductStatus.find(params[:id])
    if @product_status.update_attributes(params[:product_status])
      flash[:notice] = "Product Status updated correctly"
      redirect_to admin_product_statuses_path
    else
      flash[:notice] = "Error updating Product Status"
      render :action => 'edit'
    end
  end
  
  
end
