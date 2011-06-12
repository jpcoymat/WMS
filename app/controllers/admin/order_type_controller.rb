class OrderTypeController < ApplicationController

  before_filter :authorize
  
  def order_types
    @warehouse = User.find(session[:user_id]).warehouse
    @order_types = @warehouse.company.order_types
  end
  
  def create_order_type
    @order_type = OrderType.new(params[:order_type])
    if @order_type.save
      flash[:notice] = "Order Type created succesfully"
    else
      flash[:notice] = "Error creating Order Type"
    end
    redirect_to :controller => 'admin', :action => 'order_types'
  end
  
  def edit_order_type
    @order_type = OrderType.find(params[:order_type])
  end
  
  def update_order_type
    @order_type = OrderType.find(params[:order_type][:id])
    if @order_type.update_attributes(params[:order_type])
      flash[:notice] = "Order Type updated succesfully"
      redirect_to :controller => 'admin', :action => 'order_types'
    else
      flash[:notice] = "Error updating order type"
      redirect_to :controller => 'admin', :action => 'edit_order_type', :order_type => @order_type
    end
  end
  
  def delete_order_type
    OrderType.destroy(params[:order_type])
    flash[:notice] = "Order Type created succesfully"
    redirect_to :controller =>'admin', :action => 'order_types'
  end
  

end
