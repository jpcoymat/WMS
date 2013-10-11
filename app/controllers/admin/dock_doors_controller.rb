class Admin::DockDoorsController < ApplicationController


  def index
    @warehouse = Warehouse.find(params[:warehouse_id])
    @dock_doors = @warehouse.dock_doors    
    @dock_door = DockDoor.new
  end
  
  def create
    @warehouse = Warehouse.find(params[:dock_door][:warehouse_id])
    @dock_door = DockDoor.new(params[:dock_door])
    if @dock_door.save
      flash[:notice] = "Dock Door created succesfully"
    else
      flash[:notice] = "Error creating Dock Door"
    end
    redirect_to admin_warehouse_dock_doors_path(@warehouse.id)
  end

  def edit
    @dock_door = DockDoor.find(params[:id])
    @warehouse = @dock_door.warehouse
  end
  
  def update
    @dock_door = DockDoor.find(params[:id])
    if @dock_door.update_attributes(params[:dock_door])
      redirect_to admin_warehouse_dock_doors_path(@dock_door.warehouse_id)
    else
      flash[:notice] = "Error updating Dock Door"
      @warehouse = @dock_door.warehouse
      redirect_to :action => 'edit'
    end
  end
  
  def destroy
    @warehouse = DockDoor.find(params[:id]).warehouse
    DockDoor.destroy(params[:id])
    redirect_to admin_warehouse_dock_doors_path(@warehouse.id)
  end


end
