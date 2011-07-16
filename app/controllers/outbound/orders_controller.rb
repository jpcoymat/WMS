class Outbound::OrdersController < ApplicationController

  def lookup
    @company = User.find(session[:user_id]).company
    @customers = @company.customers
    @order_states = Order.states
    @order_type = @company.order_types
  end
  
  

end
