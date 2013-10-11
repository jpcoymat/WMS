class Inbound::PurchaseOrderLinesController < ApplicationController


  def create
    @purchase_order = PurchaseOrder.find(params[:purchase_order_line][:purchase_order_id])
    @purchase_order_line = PurchaseOrderLine.new(params[:purchase_order_line])
    if @purchase_order_line.save
      flash[:notice] = "Purchase Order Line created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Line"
    end
    redirect_to inbound_purchase_order_path(@purchase_order)    
  end
  
  def new
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id]) 
    @company = @purchase_order.company
    @purchase_order.supplier.nil? ? @products = @company.products : @products = @purchase_order.supplier.products
    @purchase_order_line = PurchaseOrderLine.new
    
  end

  def edit
    @purchase_order_line = PurchaseOrderLine.find(params[:id])
    @purchase_order = @purchase_order_line.purchase_order
    @company = @purchase_order.company
    @purchase_order.supplier.nil? ? @products = @company.products : @products = @purchase_order.supplier.products
  end
  
  def update
    @purchase_order_line = PurchaseOrderLine.find(params[:id])
    if @purchase_order_line.update_attributes(params[:purchase_order_line])
      redirect_to inbound_purchase_order_path(@purchase_order_line.purchase_order)
    else
      flash[:notice] = "Error updating Puchase Order Line"
      @purchase_order = @purchase_order_line.purchase_order
      @company = @purchase_order.company
      @purchase_order.supplier.nil? ? @products = @company.products : @products = @purchase_order.supplier.products
      render :action => 'edit'
    end    
  end

  def create
    @purchase_order_line = PurchaseOrderLine.new(params[:purchase_order_line])
    if @purchase_order_line.save
      flash[:notice] = "PO Line saves successfully"
      redirect_to inbound_purchase_order_path(@purchase_order_line.purchase_order)
    else
      flash[:notice] = "Error sacing PO Line"
      @purchase_order = PurchaseOrder.find(params[:purchase_order_id]) 
      @company = @purchase_order.company
      @purchase_order.supplier.nil? ? @products = @company.products : @products = @purchase_order.supplier.products
      render :action => 'new'
    end
  end

  def destroy
    @purchase_order_line = PurchaseOrderLine.find(params[:id])
    @purchase_order = @purchase_order_line.purchase_order
    @purchase_order_line.destroy if @purchase_order_line.deleteable?
    redirect_to inbound_purchase_order_path(@purchase_order)    
  end

end
