class Admin::SupplierController < ApplicationController

  before_filter :authorize

  def suppliers
    @suppliers = Supplier.all(:conditions => ["company_id = ?", User.find(session[:user_id]).company.id])
  end
  
  def create_supplier
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:notice] = "New supplier created"
    else
      flash[:notice] = "Error creating supplier"
    end
    redirect_to :controller => 'admin', :action => 'suppliers'
  end
  
  def edit_supplier
    @supplier = Supplier.find(params[:supplier])
  end
  
  def update_supplier
    @supplier = Supplier.find(params[:supplier][:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "Supplier updated succesfully"
      redirect_to :controller => 'admin', :action => 'suppliers'
    else
      flash[:notice] = "An error occurred updating suppliers"
      redirect_to :controller => 'admin', :action => 'edit_supplier', :supplier => @supplier
    end
  end
  
  def delete_supplier
    Supplier.destroy(params[:supplier])
    redirect_to :controller => 'admin', :action => 'suppliers'
  end


end
