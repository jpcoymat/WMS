class Admin::ProductSubcategoryController < ApplicationController

  before_filter :authorize


  def product_subcategories
    @product_category = ProductCategory.find(params[:product_category])
    @product_subcategories = @product_category.product_subcategories
  end
  
  def create_product_subcategory
    @product_category = ProductCategory.find(params[:product_subcategory][:product_category_id])
    @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
    if @product_subcategory.save
      flash[:notice] = "Product Subcategory created succesfully"
    else
      flash[:notice] = "Error creating Product Subcategory"
    end
    redirect_to(product_subcategories_url)
  end
  
  def edit_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory])
  end
  
  def update_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory][:id])
    if @product_subcategory.update_attributes(params[:product_subcategory])
      flash[:notice] = "Product Subcategory updated correctly"
      redirect_to @product_subcategory
    else
      flash[:notice] = "Error updating Product Subcategory"
      render :action => 'edit_product_subcategory'    
    end
  end
  
  def delete_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory])
    @product_category = @product_subcategory.product_category
    @product_subcategory.destroy
    flash[:notice] = "Product Subcategory deleted"
    redirect_to(product_subcategories_url)
  end


end
