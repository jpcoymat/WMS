class Admin::LocationTypesController < ApplicationController

  before_filter :authorize

  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @location_types = @warehouse.location_types
    @location_type = LocationType.new
  end
  
  def create
    @location_type = LocationType.new(params[:location_type])
    unless @location_type.save
      flash[:notice] = "Error creating Location Type"
    end
    redirect_to admin_location_types_path
  end
  
  def show
    @location_type = LocationType.find(params[:id])
  end
  
  def edit
    @location_type = LocationType.find(params[:id])
  end
  
  def update
    @location_type = LocationType.find(params[:id])
    if @location_type.update_attributes(params[:location_type])
      redirect_to admin_location_types_path
    else
      flash[:notice] = "Error updating location type"
      render :action => 'edit'
    end
  end



end
