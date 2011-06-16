class Admin::ProductSubcategoriesController < ApplicationController

  before_filter :authorize


  def index
    @product_category = ProductCategory.find(params[:product_category_id])
    @product_subcategories = @product_category.product_subcategories
    @product_subcategory = ProductSubcategory.new
  end
  
  def create
    @product_category = ProductCategory.find(params[:product_subcategory][:product_category_id])
    @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
    if @product_subcategory.save
      flash[:notice] = "Product Subcategory created succesfully"
    else
      flash[:notice] = "Error creating Product Subcategory"
    end
    redirect_to admin_product_category_product_subcategories_path(@product_category.id)
  end
  
  def edit
    @product_subcategory = ProductSubcategory.find(params[:id])
    @product_category = @product_subcategory.product_category
  end
  
  def update
    @product_subcategory = ProductSubcategory.find(params[:id])
    if @product_subcategory.update_attributes(params[:product_subcategory])
      @product_category = @product_subcategory.product_category
      flash[:notice] = "Product Subcategory updated correctly"
      redirect_to admin_product_category_product_subcategories_path(@product_category.id)
    else
      flash[:notice] = "Error updating Product Subcategory"
      render :action => 'edit_product_subcategory'    
    end
  end
  
  def destroy
    @product_subcategory = ProductSubcategory.find(params[:id])
    @product_category = @product_subcategory.product_category
    @product_subcategory.destroy
    flash[:notice] = "Product Subcategory deleted"
    redirect_to admin_product_category_product_subcategories_path(@product_category.id)
  end


end
