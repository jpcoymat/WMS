class Admin::OrderTypesController < ApplicationController

  
  def index
    @warehouse = current_user.warehouse
    @order_types = @warehouse.company.order_types
    @order_type = OrderType.new
  end
  
  def create
    @order_type = OrderType.new(params[:order_type])
    if @order_type.save
      flash[:notice] = "Order Type created succesfully"
    else
      flash[:notice] = "Error creating Order Type"
    end
    redirect_to admin_order_types_path
  end
  
  def edit
    @order_type = OrderType.find(params[:id])
  end
  
  def update
    @order_type = OrderType.find(params[:id])
    if @order_type.update_attributes(params[:order_type])
      flash[:notice] = "Order Type updated succesfully"
      redirect_to admin_order_types_path
    else
      flash[:notice] = "Error updating order type"
      render :action => 'edit'
    end
  end
  
  def destroy
    OrderType.destroy(params[:id])
    flash[:notice] = "Order Type created succesfully"
    redirect_to admin_order_types_path
  end
  

end
