class Admin::DockDoorsController < ApplicationController


  before_filter :authorize


  def index
    @warehouse = Warehouse.find(params[:warehouse])
    @dock_doors = @warehouse.dock_doors    
  end
  
  def create
    @warehouse = Warehouse.find(params[:dock_door][:warehouse_id])
    @dock_door = DockDoor.new(params[:dock_door])
    if @dock_door.save
      flash[:notice] = "Dock Door created succesfully"
    else
      flash[:notice] = "Error creating Dock Door"
    end
    redirect_to :controller => 'admin', :action => 'dock_doors', :warehouse => @warehouse
  end

  def edit
    @dock_door = DockDoor.find(params[:dock_door])
  end
  
  def update
    @dock_door = DockDoor.find(params[:dock_door][:id])
    if @dock_door.update_attributes(params[:dock_door])
      redirect_to :controller => 'admin', :action => 'dock_doors', :warehouse => @dock_door.warehouse
    else
      flash[:notice] = "Error updating Dock Door"
      redirect_to :controller => 'admin', :action => 'edit_dock_door', :dock_door => @dock_door
    end
  end


end
