class ReceiptTypeController < ApplicationController

  before_filter :authorize
  
  def receipt_types
    @company = User.find(session[:user_id]).company
    @receipt_types = @company.receipt_types
  end
  
  def create_receipt_type
    @receipt_type = ReceiptType.new(params[:receipt_type])
    if @receipt_type.save
      flash[:notice] = "Receipt Type created succesfully"
    else
      flash[:notice] = "Error creating Receipt Type"
    end
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  
  def edit_receipt_type 
    @receipt_type = ReceiptType.find(params[:receipt_type])
  end
  
  def update_receipt_type
    @receipt_type = ReceiptType.find(params[:receipt_type][:id])
    if @receipt_type.update_attributes(params[:receipt_type])
      redirect_to :controller => 'admin', :action => 'receipt_types'
    else
      flash[:notice] = "Error updating Receipt Type"
      redirect_to :controller => 'admin', :action => 'edit_receipt_type', :receipt_type => @receipt_type
    end
  end  
  
  def delete_receipt_type
    ReceiptType.destroy(params[:receipt_type])
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  

end
