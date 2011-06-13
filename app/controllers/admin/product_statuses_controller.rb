class Admin::ProductStatusesController < ApplicationController
  
  before_filter :authorize
  
  
  def index
    @company = User.find(session[:user_id]).company
    @product_statuses = ProductStatus.all
  end
  
  def create
    @product_status = ProductStatus.new(params[:product_status])
    if @product_status.save
      flash[:notice] = "Product Status created succesfully"
    else
      flash[:notice] = "Error creating product status"
    end
    redirect_to :controller => 'admin', :action => 'product_statuses'
  end
  
  def edit
    @product_status = ProductStatus.find(params[:product_status])
  end
  
  def update
    @product_status = ProductStatus.find(params[:product_status][:id])
    if @product_status.update_attributes(params[:product_status])
      flash[:notice] = "Product Status updated correctly"
    else
      flash[:notice] = "Error updating Product Status"
    end
    redirect_to :controller => 'admin', :action => 'product_statuses'
  end
  
  
end
