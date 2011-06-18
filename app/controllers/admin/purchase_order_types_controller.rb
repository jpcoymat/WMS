class Admin::PurchaseOrderTypesController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @purchase_order_types = PurchaseOrderType.all(:conditions => ["company_id = ?", @warehouse.company.id])
    @purchase_order_type = PurchaseOrderType.new
  end
  
  def create
    @purchase_order_type = PurchaseOrderType.new(params[:purchase_order_type])
    if @purchase_order_type.save
      flash[:notice] = "Purchase Order Type created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Type"
    end
    redirect_to admin_purchase_order_types_path
  end
  
  def edit
    @purchase_order_type = PurchaseOrderType.find(params[:id])
  end
  
  def update
    @purchase_order_type = PurchaseOrderType.find(params[:id])
    if @purchase_order_type.update_attributes(params[:purchase_order_type])
      flash[:notice] = "Purchase Order Type udpated succesfully"
      redirect_to admin_purchase_order_types_path
    else
      flash[:notice] = "Error updating Purchase Order Type"
      render :action => 'edit'      
    end
  end
  
  def destroy
    @purchase_order_type = PurchaseOrderType.find(params[:id])
    @purchase_order_type.destroy
    redirect_to admin_purchase_order_types_path
  end
  

end
