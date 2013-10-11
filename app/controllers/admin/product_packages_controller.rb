class Admin::ProductPackagesController < ApplicationController


  def index
    @product = Product.find(params[:product_id])
    @product_package = ProductPackage.new
  end
  
  def create
    @product = Product.find(params[:product_package][:product_id])
    @product_package = ProductPackage.new(params[:product_package])
    if @product_package.save
      flash[:notice] = "Product Package record created succesfully"
    else
      flash[:notice] = "Error creating Product Package record"
    end
    redirect_to admin_product_product_packages_path(@product.id)
  end

  def edit
    @product_package = ProductPackage.find(params[:id])
    @product = @product_package.product
  end
  
  def update
    @product_package = ProductPackage.find(params[:id])
    if @product_package.update_attributes(params[:product_package])
      flash[:notice] = "Prouct Package record updated succesfully"
      redirect_to admin_product_product_packages_path(@product_package.product.id)
    else
      flash[:notice] = "Error updating Product Package"
      @product = @product_package.product
      render :action => 'edit_product_package'
    end
  end

  def destroy
    @product_package = ProductPackage.find(params[:id])
    @product = @product_package.product
    @product_package.destroy
    redirect_to admin_product_product_packages_path(@product.id)
  end

end
