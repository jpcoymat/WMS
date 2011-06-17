class Admin::ProductLocationAssignmentsController < ApplicationController

  before_filter :authorize
  
  def index
    @location = Location.find(params[:location])
    @product_location_assignments = @location.product_location_assignments
    @warehouse = @location.warehouse
    @products = @warehouse.products
  end
  
  def create
    @product_location_assignment = ProductLocationAssignment.new(params[:product_location_assignment])
    @location = Location.find(params[:product_location_assignment][:location_id])
    if @product_location_assignment.save
      flash[:notice] = "Product Location Assignment created"
    else
      flash[:notice] = "Error creating Product Location Assignment"
    end
    redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @location
  end
  
  def edit
    @product_location_assignment = ProductLocationAssignment.find(params[:product_location_assignment])
    @location = @product_location_assignment.location
    @warehouse = @location.warehouse
    
  end
  
  def update
    @product_location_assignment = ProductLocationAssignment.find(params[:product_location_assignment][:id])
    if @product_location_assignment.update_attributes(params[:product_location_assignment])
      redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @product_location_assignment.location
    else
      flash[:notice] = "Error updating Product Location Assignment"
      redirect_to :controller => 'admin', :action => 'edit_product_location_assignment', :product_location_assignment => @product_location_assignment 
    end    
  end
  
  def destroy
    @location = ProductLocationAssignment.find(params[:product_location_assignment]).location
    ProductLocationAssignment.destroy(params[:product_location_assignment])
    redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @location
  end
  

end
