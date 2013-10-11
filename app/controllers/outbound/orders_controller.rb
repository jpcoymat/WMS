class Outbound::OrdersController < ApplicationController

  def lookup
    @company = current_user.company
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
    @company = current_user.company
    @order_type = @company.order_types
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to outbound_order_path(@order)
    else
      render :action => 'edit'
      @company = current_user.company
      @order_type = @company.order_types
    end
  end
  
  def new
    @order = Order.new
    @order.order_lines.build
    @company = current_user.company
    @warehouses = @company.warehouses
    @products = @company.products
    @product_statuses = @company.product_statuses
    @order_types = @company.order_types
    @customers = @company.customers
    @countries = Country.all
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Order created succesfully"
      redirect_to outbound_order_path(@order)
    else
      flash[:notice] = "Error while creating Order"
      @order.order_lines.build
      @company = current_user.company
      @warehouses = @company.warehouses
      @products = @company.products
      @product_statuses = @company.product_statuses
      @order_types = @company.order_types
      @customers = @company.customers
      @countries = Country.all
      render :action => 'new'
    end
  end
  
  

end
