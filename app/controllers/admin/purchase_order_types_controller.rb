class Admin::PurchaseOrderTypesController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @purchase_order_types = PurchaseOrderType.all(:conditions => ["company_id = ?", @warehouse.company.id])
  end
  
  def create
    @purchase_order_type = PurchaseOrderType.new(params[:purchase_order_type])
    if @purchase_order_type.save
      flash[:notice] = "Purchase Order Type created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Type"
    end
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  
  def edit
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type])
  end
  
  def update
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type][:id])
    if @purchase_order_type.update_attributes(params[:purchase_order_type])
      flash[:notice] = "Purchase Order Type udpated succesfully"
      redirect_to :controller => 'admin', :action => 'purchase_order_types'
    else
      flash[:notice] = "Error updating Purchase Order Type"
      redirect_to :controller => 'admin', :action => 'edit_purchase_order_type', :purchase_order_type => @purchase_order_type      
    end
  end
  
  def destroy
    PurchaseOrderType.destroy(params[:purchase_order_type])
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  

end
