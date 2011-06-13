class Admin::LocationTypesController < ApplicationController

  before_filter :authorize

  def index
    @location_types = LocationType.all(:order => "code")
  end
  
  def create
    @location_type = LocationType.new(params[:location_type])
    unless @location_type.save
      flash[:notice] = "Error creating Location Type"
    end
    redirect_to :controller => 'admin', :action => 'location_types'
  end
  
  def show
    @location_type = LocationType.find(params[:location_type])
  end
  
  def edit
    @location_type = LocationType.find(params[:location_type])
  end
  
  def update
    @location_type = LocationType.find(params[:location_type][:id])
    if @location_type.update_attributes(params[:location_type])
      redirect_to :controller => 'admin', :action => 'location_types'
    else
      flash[:notice] = "Error updating location type"
      redirect_to :controller => 'admin', :action => 'edit_location_type', :location_type => @location_type
    end
  end



end
