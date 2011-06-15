class Admin::ProductCategoriesController < ApplicationController

  def index
    @product_categories = ProductCategory.all(:order => "name", :conditions => ["company_id = ?", User.find(session[:user_id]).warehouse.company_id])
  end
  
  def show
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      flash[:notice] = "New Product Category created succesfully"
    else   
      flash[:notice] = "Error Creating Product Category"
    end
    redirect_to(product_categories_url)
  end
  
  def edit
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def update
    @product_category = ProductCategory.find(params[:product_category][:id])
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Product Category updated correctly"
      redirect_to @product_category
    else
      flash[:notice] = "Error updating Product Category"
      render :action => 'edit_product_category'
    end
  end
  
  
  
  def destroy
    @product_category = ProductCategory.find(params[:product_category])
    @product_category.destroy
    flash[:notice] = "Product Category has been deleted"
    redirect_to(product_categories_url)
  end


end
