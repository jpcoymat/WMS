class WarehouseController < ApplicationController


  before_filter :authorize


  def warehouses
    @company = User.find(session[:user_id]).company 
  end
  
  def view_warehouse
    @warehouse = Warehouse.find(params[:warehouse])
  end
  
  def add_warehouse
    @warehouse = Warehouse.new
  end
  
  def create_warehouse
    @warehouse = Warehouse.new(params[:warehouse])
    if @warehouse.save
      @warehouse.add_system_parameters
      redirect_to @warhouse
    else
      flash[:notice] = "Error creating new warehouse.  Please try again."
      render :action => 'add_warehouses'
    end
  end
  
  def edit_warehouse
    @warehouse = Warehouse.find(params[:warehouse])    
  end
  
  def update_warehouse
    @warehouse = Warehouse.find(params[:warehouse][:id])
    if @warehouse.update_attributes(params[:warehouse])
      redirect_to @warehouse
    else
      flash[:notice] = "Error updating warehouse.  Please try again."
      render :action => 'edit_warehouse'
    end
  end
  
  def delete_warehouse
    Warehouse.destroy(params[:warehouse])
    redirect_to(warehouses_url)
  end

end
