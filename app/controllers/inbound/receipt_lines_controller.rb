class Inbound::ReceiptLinesController < ApplicationController


  def index
    @receipt = Receipt.find(params[:id])
    @company = @receipt.warehouse.company
    @receipt_line = ReceiptLine.new
  end
  
  def new
    @company = current_user.company
    @receipt_line = ReceiptLine.new
    @receipt = Receipt.find(params[:receipt_id])
    @purchase_order_lines = PurchaseOrderLine.all
    @purchase_orders = PurchaseOrder.all
  end

  
  def create
    @receipt = Receipt.find(params[:receipt_line][:receipt_id])
    @receipt_line = ReceiptLine.new(params[:receipt_line])
    if @receipt_line.save
      flash[:notice] = "Receipt Line created"
    else
      flash[:notice] = "Error creating Receipt Line"
    end
    redirect_to inbound_receipt_path(@receipt)    
  end

  def edit
    @receipt_line = ReceiptLine.find(params[:id])
  end
  
  def update
    @receipt_line = ReceiptLine.find(params[:id])
    if @receipt_line.update_attributes(params[:receipt_line])
      redirect_to inbound_receipt_path(@receipt_line.receipt)
    else
      flash[:notice] = "Error updating Receipt Line"
      render :action => 'edit'
    end    
  end

end
