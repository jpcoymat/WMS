class InventoryManagementController < ApplicationController

  def index
  end

  def containers
	@open_shipments = User.find(session[:user_id]).warehouse.open_shipments
	if request.post?
		container_criteria = params[:container].clone
		container_criteria.delete_if {|k,v| v.is_blank? }
		@containers = Container.where(container_criteria).all 
	end
  end

  def inventory_updates
  end

  def locations
  end

  def shipments
  end

  def assignments
  end

end
