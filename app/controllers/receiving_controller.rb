class ReceivingController < ApplicationController

  def index

  end

  def purchase_orders
    @company = User.find(session[:user_id]).company
    if request.post?
      params[:purchase_order_criteria].delete_if {|k,v| v.blank?}
      @purchase_orders = PurchaseOrder.all(:conditions => params[:purchase_orders], :order => 'purchase_order_number')
    end
  end
  
  def new_purchase_order
    @company = User.find(session[:user_id]).company
    @purchase_order = PurchaseOrder.new
  end

  def create_purchase_order
    @purchase_order = PurchaseOrder.new(params[:purchase_order])
    if @purchase_order.save
      redirect_to :controller => 'receiving', :action => 'purchase_order_lines', :purchase_order => @purchase_order
    else
      flash[:notice] = "Error creating Purchase Order.  Please try again."
      redirect_to :controller => 'receiving', :action => 'new_purchase_order'
    end
  end
  
  def edit_purchase_order
    @purchase_order = PurchaseOrder.find(params[:purchase_order])
    @company = @purchase_order.company
  end
  
  def update_purchase_order
    @purchase_order = PurchaseOrder.find(params[:purchase_order][:id])
    if @purchase_order.update_attributes(params[:purchase_order])
      redirect_to :controller => 'receiving', :action => 'view_purchase_order', :purchase_order => @purchase_order
    end
  end
  
  def purchase_order_lines
    @purchase_order = PurchaseOrder.find(params[:purchase_order])
    @company = @purchase_order.company
  end
  
  def create_purchase_order_line
    @purchase_order = PurchaseOrder.find(params[:purchase_order_line][:purchase_order_id])
    @purchase_order_line = PurchaseOrderLine.new(params[:purchase_order_line])
    if @purchase_order_line.save
      flash[:notice] = "Purchase Order Line created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Line"
    end
    redirect_to :controller => 'receiving', :action => 'purchase_order_lines', :purchase_order => @purchase_order
  end
  
  def edit_purchase_order_line
    @purchase_order_line = PurchaseOrderLine.find(params[:purchase_order_line])
    @company = @purchase_order_line.purchase_order.company
  end
  
  def update_purchase_order_line
    @purchase_order_line = PurchaseOrderLine.find(params[:purchase_order_line][:id])
    if @purchase_order_line.update_attributes(params[:purchase_order_line])
      redirect_to :controller => 'receiving', :action => 'purchase_order_lines', :purchase_order => @purchase_order_line.purchase_order
    else
      flash[:notice] = "Error updating Puchase Order Line"
      redirect_to :controller => 'receiving', :action => 'edit_purchase_order_line', :edit_purchase_order_line => @purchase_order_line
    end
  end

  def view_purchase_order
    @purchase_order = PurchaseOrder.find(params[:purchase_order])
    @company = @purchase_order.company
  end

  def receipts
    @warehouse = User.find(session[:user_id]).warehouse
    if request.post?
      params[:receipt_search_criteria].delete_if {|k,v| v.blank?}
      @receipts = Receipt.all(:conditions => params[:receipt_search_criteria], :order => 'receipt_number')
    end
  end
  
  def new_receipt
    @warehouse = User.find(session[:user_id]).warehouse
    @receipt = Receipt.new
  end
  
  def create_receipt
    @receipt = Receipt.new(params[:receipt])
    if @receipt.save
      redirect_to :controller => 'receiving', :action => 'receipt_lines', :receipt => @receipt
    else
      flash[:notice] = "Error creating receipt"
      @receipt.errors.full_messages.each {|msg| flash[:notice] += msg}
      redirect_to :controller => 'receiving', :action => 'new_receipt'
    end
  end
    
  def edit_receipt
    @receipt = Receipt.find(params[:receipt])
  end
  
  def update_receipt
    @receipt = Receipt.find(params[:receipt][:id])
    if @receipt.update_attributes(params[:receipt])
      redirect_to :controller => 'receiving', :action => 'view_receipt', :receipt => @receipt
    else
      flash[:notice] = "Error updating Receipt"
      redirect_to :controller => 'receiving', :action => 'edit_receipt', :receipt => @receipt
    end
  end
  
  def receipt_lines
    @receipt = Receipt.find(params[:receipt])
    @company = @receipt.warehouse.company
  end
  
  def create_receipt_line
    @receipt = Receipt.find(params[:receipt_line][:receipt_id])
    @receipt_line = ReceiptLine.new(params[:receipt_line])
    if @receipt_line.save
      flash[:notice] = "Receipt Line created"
    else
      flash[:notice] = "Error creating Receipt Line"
    end
    redirect_to :controller => 'receiving', :action => 'receipt_lines', :receipt => @receipt
  end
  
  def edit_receipt_line
    @receipt_line = ReceiptLine.find(params[:receipt_line])
  end
  
  def update_receipt_line
    @receipt_line = ReceiptLine.find(params[:receipt_line][:id])
    if @receipt_line.update_attributes(params[:receipt_line])
      redirect_to :controller => 'receiving', :action => 'receipt_lines', :receipt => @receipt_line.receipt
    else
      flash[:notice] = "Error updating Receipt Line"
      redirect_to :controller => 'receiving', :action => 'edit_receipt_line', :receipt_line => @receipt_line
    end
  end

end
