class InboundController < ApplicationController
  
  before_filter :authorize
  
  def index
    @warehouse = @warehouse = User.find(session[:user_id]).warehouse
  end
  
  def start_receiving
    @warehouse = User.find(session[:user_id]).warehouse
    @available_dock_doors = @warehouse.dock_doors
    @available_receipts = @warehouse.receivable_receipts
  end

  def confirm_lp
    @dock_door  = DockDoor.find(params[:dock_door_id])
    @receipt    = Receipt.find(params[:receipt_id])
  end
  
  def receive_receipt_line
    @receipt_lines = ReceiptLine.where(:lp => params[:receipt_line][:lp], :receipt_id => params[:receipt_line][:receipt_id]).all
    unless @receipt_lines.empty?
      if @receipt_lines.first.created?
        @receipt = Receipt.find(params[:receipt_line][:receipt_id])
        @dock_door = DockDoor.find(params[:receipt_line][:dock_door_id])
        if @receipt.created?
          @receipt.received_at = Time.now
          @receipt.start_receiving
          @receipt.save!
        end
        @receipt_lines.each do |receipt_line|
          receipt_line.received_at = Time.now
          receipt_line.dock_door_id = params[:receipt_line][:dock_door_id]
          receipt_line.start_receiving
          receipt_line.save!
        end
        Container.create_from_receipt_lines(params[:receipt_line][:lp], @dock_door)
        flash[:notice] = "Yay! LP #{params[:receipt_line][:lp]} was received succesfully"       
      else
        flash[:notice] = "Oops.  LP #{params[:receipt_line][:lp]} has already been received"
      end
    else
      flash[:notice] = "Oops. LP #{params[:receipt_line][:lp]} is invalid"
    end
    redirect_to :controller =>'inbound', :action => 'confirm_lp', :dock_door_id => params[:receipt_line][:dock_door_id], :receipt_id => params[:receipt_line][:receipt_id]
  end
  
  def close_receipt
    @warehouse = User.find(session[:user_id]).warehouse
    @closeable_receipts = @warehouse.closeable_receipts
  end
  
  def complete_receipt
    @receipt = Receipt.find(params[:receipt][:id])
    unless @receipt.canceled? || @receipt.completed?
      @receipt.receipt_lines.each do |receipt_line|
        receipt_line.cancel
        receipt_line.save!
      end
      @receipt.complete_receiving
      @receipt.save!
      flash[:notice] = "Receipt #{@receipt.receipt_number} closed succesfully."
    else
      flash[:notice] = "Receipt #{@receipt.receipt_number} in wrong status to close ( #{@receipt.state} )"  
    end
    redirect_to :controller => 'inbound', :action => 'close_receipt'
  end


  def receive_purchase_order
     @warehouse = User.find(session[:user_id]).warehouse
     @receivable_purchase_orders = @warehouse.receivable_purchase_orders 
  end

 

end
