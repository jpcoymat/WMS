class Admin::ReceiptTypesController < ApplicationController

  before_filter :authorize
  
  def index
    @company = User.find(session[:user_id]).company
    @receipt_types = @company.receipt_types
    @receipt_type = ReceiptType.new
  end
  
  def create
    @receipt_type = ReceiptType.new(params[:receipt_type])
    if @receipt_type.save
      flash[:notice] = "Receipt Type created succesfully"
    else
      flash[:notice] = "Error creating Receipt Type"
    end
    redirect_to admin_receipt_types_path
  end
  
  def edit 
    @receipt_type = ReceiptType.find(params[:id])
  end
  
  def update
    @receipt_type = ReceiptType.find(params[:id])
    if @receipt_type.update_attributes(params[:receipt_type])
      redirect_to admin_receipt_types_path
    else
      flash[:notice] = "Error updating Receipt Type"
      render 'edit'
    end
  end  
  
  def destroy
    @receipt_type = ReceiptType.find(params[:id])
    @receipt_type.destroy
    redirect_to admin_receipt_types_path
  end
  

end
