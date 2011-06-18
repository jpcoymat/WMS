class Admin::ProductWarehouseSetupsController < ApplicationController

  before_filter :authorize

  def index
    @product = Product.find(params[:product_id])
    @product_warehouse_setup = ProductWarehouseSetup.new
  end
  
  def create
    @product = Product.find(params[:product_warehouse_setup][:product_id])
    @product_warehouse_setup = ProductWarehouseSetup.new(params[:product_warehouse_setup])
    if @product_warehouse_setup.save
      flash[:notice] = "Product Warehouse Setup saved"
    else
      flash[:notice] = "Error creating Product Warehouse Setup"
    end
    redirect_to admin_product_product_warehouse_setups_path(@product,@product_warehouse_setup)
  end
  
  def edit
    @product_warehouse_setup = ProductWarehouseSetup.find(params[:id])
    @product = @product_warehouse_setup.product  
  end
  
  def update
    @product_warehouse_setup = ProductWarehouseSetup.find(params[:id])
    if @product_warehouse_setup.update_attributes(params[:product_warehouse_setup])
      redirect_to admin_product_product_warehouse_setups_path(@product_warehouse_setup.product_id)
    else
      flash[:notice] = "Error updating Product Warehouse Setup"
      @product = @product_warehouse_setup.product  
      render :action => 'edit'
    end
  end
  
  def destroy
    @product_warehouse_setup = ProductWarehouseSetup.find(params[:id])
    @product = @product_warehouse_setup.product  
    @product_warehouse_setup.destroy
    redirect_to admin_product_product_warehouse_setups_path(@product.id)
  end

end
