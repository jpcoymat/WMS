class AllocationZoneController < ApplicationController

  before_filter :authorize
  
  def allocation_zones	
    @warehouse = User.find(session[:user_id]).warehouse	
  end

  def	create_allocation_zone
    @allocation_zone = AllocationZone.new(params[:allocation_zone])
    if @allocation_zone.save
	    flash[:notice] = "New allocation zone created correctly."
    else
	    flash[:notice] = "Error creating Allocation Zone"
    end
    redirect_to :controller => 'admin', :action => 'allocation_zones'
  end

  def edit_allocation_zone	
    @allocation_zone = AllocationZone.find(params[:allocation_zone])
  end 

  def update_allocation_zone
    @allocation_zone = AllocationZone.find(params[:allocation_zone][:id])
    if @allocation_zone.update_attributes(params[:allocation_zone])
	    flash[:notice] = "Allocation Zone updated correctly."
	    redirect_to :controller => 'admin', :action => 'allocation_zones'
    else
	    flash[:notice] = "Error updating Allocation Zone"
	    redirect_to :controller => 'admin', :action => 'edit_allocation_zone', :allocation_zone => @allocation_zone
    end
  end

  def delete_allocation_zone	
	  AllocationZone.destroy(params[:allocation_zone])
	  redirect_to :controller => 'admin', :action => 'allocation_zones'
  end
  


end
