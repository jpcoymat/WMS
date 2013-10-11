class Admin::ProductLocationAssignmentsController < ApplicationController

  
  def replenishment_locations
    @warehouse = current_user.warehouse
    if request.post?
      location_criteria = params[:location].clone
      location_criteria.delete_if {|k,v| v.blank?}
      @locations = Location.where(:warehouse_id => @warehouse.id, :replenishable => true)
      @locations.where(location_criteria).order('name').all
    end
  end

  def index
    @location = Location.find(params[:location_id])
    @product_location_assignments = @location.product_location_assignments
    @warehouse = @location.warehouse
    @products = @warehouse.products
    @product_location_assignment = ProductLocationAssignment.new
  end
  
  def create
    @product_location_assignment = ProductLocationAssignment.new(params[:product_location_assignment])
    @location = Location.find(params[:product_location_assignment][:location_id])
    if @product_location_assignment.save
      flash[:notice] = "Product Location Assignment created"
    else
      flash[:notice] = "Error creating Product Location Assignment"
    end
    redirect_to admin_product_location_assignments_path(:location_id => @location.id)
  end
  
  def edit
    @product_location_assignment = ProductLocationAssignment.find(params[:id])
    @location = @product_location_assignment.location
    @warehouse = @location.warehouse
    @products = @warehouse.products
    
  end
  
  def update
    @product_location_assignment = ProductLocationAssignment.find(params[:product_location_assignment][:id])
    if @product_location_assignment.update_attributes(params[:product_location_assignment])
      redirect_to admin_product_location_assignments_path(:location_id => @product_location_assignment.location.id)
    else
      @location = @product_location_assignment.location
      @warehouse = @location.warehouse
      @products = @warehouse.products
      flash[:notice] = "Error updating Product Location Assignment"
      render :action => 'edit' 
    end    
  end
  
  def destroy
    @product_location_assignment = ProductLocationAssignment.find(params[:id])
    @location = @product_location_assignment.location
    @product_location_assignment.destroy
    redirect_to admin_product_location_assignments_path(:location_id => @location.id)
  end
  

end
