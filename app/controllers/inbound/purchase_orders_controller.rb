class Inbound::PurchaseOrdersController < ApplicationController

  before_filter :authorize


  def lookup
    @company = User.find(session[:user_id]).company
    if request.post?
      params[:purchase_order_criteria].delete_if {|k,v| v.blank?}
      @purchase_orders = PurchaseOrder.all(:conditions => params[:purchase_orders], :order => 'purchase_order_number')
    end
  end

  def show
    @purchase_order = PurchaseOrder.find(params[:id])
    @company = @purchase_order.company
  end
  
  def update
    @purchase_order = PurchaseOrder.find(params[:id])
    if @purchase_order.update_attributes(params[:purchase_order])
      redirect_to lookup_inbound_purchase_orders_path
    else
      @company = @purchase_order.company
      render :action => 'edit'
    end    
  end

  def new
    @company = User.find(session[:user_id]).company
    @purchase_order = PurchaseOrder.new
  end

  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    @company = @purchase_order.company
  end
  
  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])
    if @purchase_order.save
      redirect_to inbound_purchase_order_path(@purchase_order)
    else
      flash[:notice] = "Error creating Purchase Order.  Please try again."
      @company = @purchase_order.company
      render :action => 'new'
    end
  end


end
