class Admin::SuppliersController < ApplicationController


  def index
    @suppliers = Supplier.all(:conditions => ["company_id = ?", current_user.company.id])
    @supplier = Supplier.new
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:notice] = "New supplier created"
    else
      flash[:notice] = "Error creating supplier"
    end
    redirect_to admin_suppliers_path
  end
  
  def edit
    @supplier = Supplier.find(params[:id])
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "Supplier updated succesfully"
      redirect_to admin_suppliers_path
    else
      flash[:notice] = "An error occurred updating suppliers"
      render :action => 'edit'
    end
  end
  
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to admin_suppliers_path
  end


end
