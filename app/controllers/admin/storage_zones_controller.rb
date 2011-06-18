class Admin::StorageZonesController < ApplicationController

  before_filter :authorize
  
  def index
    @storage_zones = StorageZone.all(:conditions => ["warehouse_id = ?", User.find(session[:user_id]).warehouse.id])
    @storage_zone = StorageZone.new
  end
  
  def edit
    @storage_zone = StorageZone.find(params[:id])
  end
  
  def update
    @storage_zone = StorageZone.find(params[:id])
    if @storage_zone.update_attributes(params[:storage_zone])
      flash[:notice] = "Storage Zone updated correctly"
      redirect_to admin_storage_zones_path
    else
      flash[:notice] = "Error updating Storage Zone"
      render :action => 'edit'
    end
  end
  
  def create
    @storage_zone = StorageZone.new(params[:storage_zone])
    if @storage_zone.save
      flash[:notice] = "New Storage Zone created succesfully"
    else
      flash[:notice] = "Error creating new Storage Zone"
    end
    redirect_to admin_storage_zones_path
  end
  
  def destroy
    StorageZone.destroy(params[:id])
    redirect_to admin_storage_zones_path
  end
  

end
