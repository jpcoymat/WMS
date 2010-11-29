class InboundController < ApplicationController
  
  before_filter :authorize
  
  def start_receiving
    @warehouse = User.find(session[:user_id]).warehouse
    @available_dock_doors = @warehouse.available_dock_doors
    @available_receipts = @warehouse.receivable_receipts
  end

  def confirm_lp
    @dock_door  = DockDoor.find(params[:receipt_line][:dock_door_id])
    @receipt    = Receipt.find(params[:receipt_line][:receipt_id])
  end
  
  def receive_receipt_line
    @receipt_lines = ReceiptLines.where(:lp => [:receipt_line][:lp], :receipt_id => [:receipt_line][:receipt_id]).all
    unless @receipt_lines.empty?
      @receipt = Receipt.first(params[:receipt_line][:receipt_id])
      @dock_door = DockDoor.first(params[:receipt_line][:dock_door_id])
      if @receipt.state == "created"
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
      flash[:notice] = "LP #{params[:receipt_line][:lp]} received"
    else
      flash[:notice] = "LP #{params[:receipt_line][:lp]} is invalid"
    end
    redirect_to :controller =>'inbound', :action => 'confirm_lp'
  end

end
