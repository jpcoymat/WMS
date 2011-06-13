class Admin::ReceiptTypesController < ApplicationController

  before_filter :authorize
  
  def index
    @company = User.find(session[:user_id]).company
    @receipt_types = @company.receipt_types
  end
  
  def create
    @receipt_type = ReceiptType.new(params[:receipt_type])
    if @receipt_type.save
      flash[:notice] = "Receipt Type created succesfully"
    else
      flash[:notice] = "Error creating Receipt Type"
    end
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  
  def edit 
    @receipt_type = ReceiptType.find(params[:receipt_type])
  end
  
  def update
    @receipt_type = ReceiptType.find(params[:receipt_type][:id])
    if @receipt_type.update_attributes(params[:receipt_type])
      redirect_to :controller => 'admin', :action => 'receipt_types'
    else
      flash[:notice] = "Error updating Receipt Type"
      redirect_to :controller => 'admin', :action => 'edit_receipt_type', :receipt_type => @receipt_type
    end
  end  
  
  def delete
    ReceiptType.destroy(params[:receipt_type])
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  

end
