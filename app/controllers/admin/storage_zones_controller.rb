class Admin::StorageZonesController < ApplicationController

  before_filter :authorize
  
  def index
    @storage_zones = StorageZone.all(:conditions => ["warehouse_id = ?", User.find(session[:user_id]).warehouse.id])
  end
  
  def edit
    @storage_zone = StorageZone.find(params[:storage_zone])
  end
  
  def update
    @storage_zone = StorageZone.find(params[:storage_zone][:id])
    if @storage_zone.update_attributes(params[:storage_zone])
      flash[:notice] = "Storage Zone updated correctly"
      redirect_to :controller => 'admin', :action => 'storage_zones'
    else
      flash[:notice] = "Error updating Storage Zone"
      redirect_to :controller => 'admin', :action => 'edit_storage_zone', :storage_zone => @strorage_zone
    end
  end
  
  def create
    @storage_zone = StorageZone.new(params[:storage_zone])
    if @storage_zone.save
      flash[:notice] = "New Storage Zone created succesfully"
    else
      flash[:notice] = "Error creating new Storage Zone"
    end
    redirect_to :controller => 'admin', :action => 'storage_zones'
  end
  
  def delete
    StorageZone.destroy(params[:storage_zone])
    redirect_to :controller => 'admin', :action => 'storage_zones'
  end
  

end
