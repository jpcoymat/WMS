class Outbound::OrdersController < ApplicationController

  def lookup
    @company = User.find(session[:user_id]).company
    @customers = @company.customers
    @order_states = Order.states
    @order_type = @company.order_types
    if request.post?
      search_criteria = params[:order].clone
      search_criteria.delete_if {|k,v| v.blank? }
      @orders = Order.where(search_criteria).order('order_number')
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def edit
    @order = Order.find(params[:id])    
    @company = User.find(session[:user_id]).company
    @order_type = @company.order_types
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to outbound_order_path(@order)
    else
      render :action => 'edit'
      @company = User.find(session[:user_id]).company
      @order_type = @company.order_types
    end
  end
  
  
  

end
