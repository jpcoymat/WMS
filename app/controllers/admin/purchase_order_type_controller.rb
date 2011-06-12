class Admin::PurchaseOrderTypeController < ApplicationController

  before_filter :authorize
  
  def purchase_order_types
    @warehouse = User.find(session[:user_id]).warehouse
    @purchase_order_types = PurchaseOrderType.all(:conditions => ["company_id = ?", @warehouse.company.id])
  end
  
  def create_purchase_order_type
    @purchase_order_type = PurchaseOrderType.new(params[:purchase_order_type])
    if @purchase_order_type.save
      flash[:notice] = "Purchase Order Type created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Type"
    end
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  
  def edit_purchase_order_type
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type])
  end
  
  def update_purchase_order_type
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type][:id])
    if @purchase_order_type.update_attributes(params[:purchase_order_type])
      flash[:notice] = "Purchase Order Type udpated succesfully"
      redirect_to :controller => 'admin', :action => 'purchase_order_types'
    else
      flash[:notice] = "Error updating Purchase Order Type"
      redirect_to :controller => 'admin', :action => 'edit_purchase_order_type', :purchase_order_type => @purchase_order_type      
    end
  end
  
  def delete_purchase_order_type
    PurchaseOrderType.destroy(params[:purchase_order_type])
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  

end
