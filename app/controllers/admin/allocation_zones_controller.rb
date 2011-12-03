class Admin::AllocationZonesController < ApplicationController

  before_filter :authorize
  
  def index	
    @warehouse = User.find(session[:user_id]).warehouse	
    @allocation_zone = AllocationZone.new
  end

  def	create
    @allocation_zone = AllocationZone.new(params[:allocation_zone])
    if @allocation_zone.save
	    flash[:notice] = "New allocation zone created correctly."
    else
	    flash[:notice] = "Error creating Allocation Zone"
    end
    redirect_to admin_allocation_zones_path
  end

  def edit	
    @allocation_zone = AllocationZone.find(params[:id])
  end 

  def update
    @allocation_zone = AllocationZone.find(params[:id])
    if @allocation_zone.update_attributes(params[:allocation_zone])
	    flash[:notice] = "Allocation Zone updated correctly."
	    redirect_to admin_allocation_zones_path
    else
	    flash[:notice] = "Error updating Allocation Zone"
	    render :action => 'edit'
    end
  end

  def destroy	
	  AllocationZone.destroy(params[:id])
	  redirect_to :controller => 'admin', :action => 'allocation_zones'
  end
  


end
