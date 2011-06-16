class Admin::ProductCategoriesController < ApplicationController

  def index
    @product_categories = ProductCategory.all(:order => "name", :conditions => ["company_id = ?", User.find(session[:user_id]).warehouse.company_id])
    @product_category = ProductCategory.new
  end
  
  def show
    @product_category = ProductCategory.find(params[:id])
  end
  
  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      flash[:notice] = "New Product Category created succesfully"
    else   
      flash[:notice] = "Error Creating Product Category"
    end
    redirect_to(admin_product_categories_path)
  end
  
  def edit
    @product_category = ProductCategory.find(params[:id])
  end
  
  def update
    @product_category = ProductCategory.find(params[:id])
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Product Category updated correctly"
      redirect_to admin_product_categories_path
    else
      flash[:notice] = "Error updating Product Category"
      render :action => 'edit_product_category'
    end
  end
  
  
  
  def destroy
    @product_category = ProductCategory.find(params[:id])
    @product_category.destroy
    flash[:notice] = "Product Category has been deleted"
    redirect_to(admin_product_categories_path)
  end


end
