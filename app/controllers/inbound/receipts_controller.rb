class Inbound::ReceiptsController < ApplicationController


  def lookup
    @warehouse = current_user.warehouse
    if request.post?
      params[:receipt_search_criteria].delete_if {|k,v| v.blank?}
      @receipts = Receipt.all(:conditions => params[:receipt_search_criteria], :order => 'receipt_number')
    end    
  end

  def new
    @warehouse = current_user.warehouse
    @receipt = Receipt.new
  end
  
  def create
    @receipt = Receipt.new(params[:receipt])
    if @receipt.save
      redirect_to inbound_receipt_path(@receipt)
    else
      flash[:notice] = "Error creating receipt"
      @receipt.errors.full_messages.each {|msg| flash[:notice] += msg}
      @warehouse = current_user.warehouse
      render :action => 'new'
    end    
  end

  def show
    @receipt = Receipt.find(params[:id])
  end

  def edit
    @receipt = Receipt.find(params[:id])
  end

  def update
    @receipt = Receipt.find(params[:id])
    if @receipt.update_attributes(params[:receipt])
      redirect_to inbound_receipt(@receipt)
    else
      flash[:notice] = "Error updating Receipt"
      render :action => 'edit'
    end    
  end

end
