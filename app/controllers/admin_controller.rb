class AdminController < ApplicationController


  
  
  
  def locations
    @warehouse = User.find(session[:user_id]).warehouse
    if request.post?
      params[:location].delete_if {|k,v| v.blank?   }
      params[:location][:warehouse_id] = @warehouse.id
      @locations = Location.all(:conditions => params[:location], :order => 'name')
    end
  end
  
  def view_location
    @location = Location.find(params[:location])
  end
  
  def edit_location
    @location = Location.find(params[:location])
    @warehouse = @location.warehouse
  end
  
  def update_location
    @location = Location.find(params[:location][:id])
    if @location.update_attributes(params[:location])
      @location.save
      redirect_to :controller => 'admin', :action => 'view_location', :location => @location
    else
      flash[:notice] = "Error updating Location"
      redirect_to :controller => 'admin', :action => 'edit_location', :location => @location
    end
  end
  
  def add_locations
    @warehouse = User.find(session[:user_id]).warehouse
    @location_types = @warehouse.location_types
    if request.post?
      @location_type = LocationType.find(params[:location_type][:id])
    end
  end
  
  def create_locations
    @location_type = LocationType.find(params[:locations][:location_type_id])
    location_range = params[:locations].clone.delete_if {|k,v| !(k.include?("from_") or k.include?("to_"))}
    if @location_type.location_range_valid?(location_range)
      location_attributes = params[:locations].clone.delete_if { |k,v| (k.include?("from_") or k.include?("to_"))}
      code_to_execute = create_loop_string(location_range, @location_type.active_components_array, location_attributes)
      eval code_to_execute
      redirect_to :controller => 'admin', :action => 'locations'
    else
      flash[:notice] = "Location Range is not valid"
      redirect_to :controller => 'admin', :action => 'add_locations'
    end
  end

  def create_loop_string(location_range, location_components, location_attributes)
    loop_string = ""
    loc_attr = "{"
    location_attributes.each_pair do |k,v|
      loc_attr += %{ "#{k.to_s}" => "#{v.to_s}",}
    end
    loc_attr.chop!
    loc_attr += "}"
    location_components.each do |location_component|
      start = "from_" + location_component
      finish = "to_" + location_component
      loop_string += %{ for #{location_component} in ('#{location_range[start]}' .. '#{location_range[finish]}' ) 
                      }
    end
    loop_string += %{ location = Location.new(#{loc_attr}) 
                  }
    location_components.each do |location_component|
      loop_string += %{ location.#{location_component} = #{location_component} 
                    }
    end
    loop_string += %{ location.save
                      }
    location_components.count.times do 
      loop_string += %{ end 
                      }
    end
    loop_string
  end
  
    
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
  
  def users
    @warehouse = User.find(session[:user_id]).warehouse 
    @users = @warehouse.users
  end
  
  def view_user
    @user = User.find(params[:user])
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New user created succesfully"
    else
      flash[:notice] = "Error creating new user"
    end
    redirect_to :controller => 'admin', :action => 'users'
  end
  
  def edit_user
    @user = User.find(params[:user])
  end
  
  def update_user
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
      redirect_to :controller => 'admin', :action => 'users'
    else
      redirect_to :controller => 'admin', :action => 'edit_user', :user => @user
    end    
  end
  
  def purchase_order_types
    @warehouse = User.find(session[:user_id]).warehouse
    @purchase_order_types = PurchaseOrderType.all(:conditions => ["company_id = ?", @warehouse.company.id])
  end
  
  def create_purchase_order_type
    @purchase_order_type = PurchaseOrderType.new(params[:purchase_order_type])
    if @purchase_order_type.save
      flash[:notice] = "Purchase Order Type created succesfully"
    else
      flash[:notice] = "Error creating Purchase Order Type"
    end
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  
  def edit_purchase_order_type
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type])
  end
  
  def update_purchase_order_type
    @purchase_order_type = PurchaseOrderType.find(params[:purchase_order_type][:id])
    if @purchase_order_type.update_attributes(params[:purchase_order_type])
      flash[:notice] = "Purchase Order Type udpated succesfully"
      redirect_to :controller => 'admin', :action => 'purchase_order_types'
    else
      flash[:notice] = "Error updating Purchase Order Type"
      redirect_to :controller => 'admin', :action => 'edit_purchase_order_type', :purchase_order_type => @purchase_order_type      
    end
  end
  
  def delete_purchase_order_type
    PurchaseOrderType.destroy(params[:purchase_order_type])
    redirect_to :controller => 'admin', :action => 'purchase_order_types'
  end
  
  def order_types
    @warehouse = User.find(session[:user_id]).warehouse
    @order_types = @warehouse.company.order_types
  end
  
  def create_order_type
    @order_type = OrderType.new(params[:order_type])
    if @order_type.save
      flash[:notice] = "Order Type created succesfully"
    else
      flash[:notice] = "Error creating Order Type"
    end
    redirect_to :controller => 'admin', :action => 'order_types'
  end
  
  def edit_order_type
    @order_type = OrderType.find(params[:order_type])
  end
  
  def update_order_type
    @order_type = OrderType.find(params[:order_type][:id])
    if @order_type.update_attributes(params[:order_type])
      flash[:notice] = "Order Type updated succesfully"
      redirect_to :controller => 'admin', :action => 'order_types'
    else
      flash[:notice] = "Error updating order type"
      redirect_to :controller => 'admin', :action => 'edit_order_type', :order_type => @order_type
    end
  end
  
  def delete_order_type
    OrderType.destroy(params[:order_type])
    flash[:notice] = "Order Type created succesfully"
    redirect_to :controller =>'admin', :action => 'order_types'
  end
  
  def allocation_strategies
    @warehouse = User.find(session[:user_id]).warehouse
    @allocation_strategies = @warehouse.allocation_strategies
  end
  
  def create_allocation_strategy
    @allocation_strategy = AllocationStrategy.new(params[:allocation_strategy])
    if @allocation_strategy.save
      redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy
    else
      flash[:notice] = "Error creating allocation strategy"
      redirect_to :controller => 'admin', :action => 'allocation_strategy'
    end
  end
  
  def allocation_strategy_lines
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy])
  end
  
  def create_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.new(params[:allocation_strategy_line])
    if @allocation_strategy_line.save
      flash[:notice] = "Allocation Strategy Line created succesfully"
    else
      flash[:notice] = "Error creating Allocation Strategy Line"
    end
    redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy_line.allocation_strategy
  end
  
  def edit_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.find(params[:allocation_strategy_line])
  end

  def update_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.find(params[:allocation_strategy_line][:id])
    if @allocation_strategy_line.update_attributes(params[:allocation_strategy_line])
      redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy_line.allocation_strategy
    else
      flash[:notice]  = "Error updating Allocation Strategy Line"
      redirect_to :controller => 'admin', :action => 'edit_allocation_strategy_line', :allocation_strategy_line => @allocation_strategy_line  
    end
  end
  
  def delete_allocation_strategy_line
    @allocation_strategy = AllocationStrategyLine.find(params[:allocation_strategy_line]).allocation_strategy
    AllocationStrategyLine.destroy(params[:allocation_strategy_line])
    redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy
  end
  
  def edit_allocation_strategy
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy])
  end
  
  def update_allocation_strategy
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy][:id])
    if @allocation_strategy.update_attributes(params[:allocation_strategy])
      redirect_to :controller => 'admin', :action => 'allocation_strategies'
    else
      flash[:notice] = "Error updating Allocation Strategy"
      redirect_to :controller => 'admin', :action => 'edit_allocation_strategy', :allocation_strategy => @allocation_strategy  
    end
  end
  
  def delete_allocation_strategy
    AllocationStrategy.destroy(params[:allocation_strategy])
    redirect_to :controller => 'admin', :action => 'allocation_strategies'
  end
  
  def allocation_strategy_rules
    @warehouse = User.find(session[:user_id]).warehouse
    @allocation_strategy_rules = @warehouse.allocation_strategy_rules
  end
  
  def create_allocation_strategy_rule
    @allocation_strategy_rule = AllocationStrategyRule.new(params[:allocation_strategy_rule])
    if @allocation_strategy_rule.save
      flash[:notice] = "Allocation Strategy Rule created succesfully"
    else
      flash[:notice] = "Error creating Allocation Strategy Rule"
    end
    redirect_to :controller => 'admin', :action => 'allocation_strategy_rules'
  end
  
  def edit_allocation_strategy_rule
    @allocation_strategy_rule = AllocationStrategyRule.find(params[:allocation_strategy_rule])
    @warehouse = @allocation_strategy_rule.warehouse
  end
  
  def update_allocation_strategy_rule
    @allocation_strategy_rule = AllocationStrategyRule.find(params[:allocation_strategy_rule][:id])
    if @allocation_strategy_rule.update_attributes(params[:allocation_strategy_rule])
      redirect_to :controller => 'admin', :action => 'allocation_strategy_rules'
    else
      flash[:notice] = "Error updating Allocation Strategy Rule"
      redirect_to :controller => 'admin', :action => 'edit_allocation_strategy_rule', :allocation_strategy_rule => @allocation_strategy_rule
    end
  end
  
  def delete_allocation_strategy_rule
    AllocationStrategyRule.destroy(params[:allocation_strategy_rule])
    redirect_to :controller => 'admin', :action => 'allocation_strategy_rules'
  end
  
  def customer_types
    @company = User.find(session[:user_id]).company
    @customer_types = @company.customer_types
  end
  
  def create_customer_type
    @customer_type = CustomerType.new(params[:customer_type])
    if @customer_type.save
      flash[:notice] = "Customer Type created succesfully!"
    else
      flash[:notice] = "Error creating Customer Type"
    end
    redirect_to :controller => 'admin', :action => 'customer_types'
  end
  
  def edit_customer_type
    @customer_type = CustomerType.find(params[:customer_type])
  end
  
  def update_customer_type
    @customer_type = CustomerType.find(params[:customer_type][:id])
    if @customer_type.update_attributes(params[:customer_type])
      redirect_to :controller => 'admin', :action => 'customer_types'
    else
      flash[:notice] = "Error updating customer type"
      redirect_to :controller => 'admin', :action => 'edit_customer_type', :customer_type => @customer_type
    end
  end

  def delete_customer_type
    CustomerType.destroy(params[:customer_type])
    redirect_to :controller => 'admin', :action => 'customer_types'
  end
  
  def storage_strategies
    @warehouse = User.find(session[:user_id]).warehouse
    @storage_strategies = @warehouse.storage_strategies
  end
  
  def create_storage_strategy
    @storage_strategy = StorageStrategy.new(params[:storage_strategy])
    if @storage_strategy.save
      redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy
    else
      flash[:notice] = "Error creating Storage Strategy. \n" 
      @storage_strategy.errors.each_full {|msg| flash[:notice] += msg + "\n"}  
      redirect_to :controller => 'admin', :action => 'storage_strategies'
    end
  end
  
  def storage_strategy_lines
    @storage_strategy = StorageStrategy.find(params[:storage_strategy])
    @warehouse = @storage_strategy.warehouse
  end
  
  def create_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.new(params[:storage_strategy_line])
    @storage_strategy = StorageStrategy.find(params[:storage_strategy_line][:storage_strategy_id])
    if @storage_strategy_line.save
      flash[:notice] = "Storage Strategy Line added succesfully"
    else
      flash[:notice] = "Error adding Storage Strategy Line"
    end
    redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy
  end

  def edit_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.find(params[:storage_strategy_line])
    @warehouse = @storage_strategy_line.storage_strategy.warehouse
  end
  
  def update_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.find(params[:storage_strategy_line][:id])
    if @storage_strategy_line.update_attributes(params[:storage_strategy_line])
      redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy_line.storage_strategy
    else
      flash[:notice] = "Error updating Storage Strategy Line"
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy_line', :storage_strategy_line => @storage_strategy_line
    end
  end
  
  def delete_storage_strategy_line
    @storage_strategy = StorageStrategyLine.find(params[:storage_strategy_line]).storage_strategy
    StorageStrategyLine.destroy(params[:storage_strategy_line])
    redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy 
  end
  
  def edit_storage_strategy
    @storage_strategy = StorageStrategy.find(params[:storage_strategy])
  end
  
  def update_storage_strategy
    @storage_strategy = StorageStrategy.find(params[:storage_strategy][:id])
    if @storage_strategy.update_attributes(params[:storage_strategy])
      redirect_to :controller => 'admin', :action => 'storage_strategies'
    else
      flash[:notice] = "Oops.  Something went wrong.  Please try again."
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy', :storage_strategy => @storage_strategy
    end
  end
  
  def delete_storage_strategy
    StorageStrategy.delete(params[:storage_strategy])
    redirect_to :controller => 'admin', :action => 'storage_strategies'
  end

  def storage_strategy_rules
    @warehouse = User.find(session[:user_id]).warehouse
    @company = @warehouse.company
    @storage_strategy_rules = @warehouse.storage_strategy_rules
  end
  
  def create_storage_strategy_rule
    @storage_strategy_rule = StorageStrategyRule.new(params[:storage_strategy_rule])
    if @storage_strategy_rule.save
      flash[:notice] = "Storage Strategy Rule created succesfully"
    else
      flash[:notice] = "Error creating Storage Strategy Rule"
    end
    redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
  end

  def edit_storage_strategy_rule
    @warehouse = User.find(session[:user_id]).warehouse
    @company = @warehouse.company
    @storage_strategy_rule = StorageStrategyRule.find(params[:storage_strategy_rule])
  end
  
  def update_storage_strategy_rule
    @storage_strategy_rule = StorageStrategyRule.find(params[:storage_strategy_rule][:id])
    if @storage_strategy_rule.update_attributes(params[:storage_strategy_rule])
      redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
    else
      flash[:notice] = "Error updating Storage Strategy Rules"
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy_rule', :storage_strategy_rule => @storage_strategy_rule
    end
  end
  
  def delete_storage_strategy_rule
    StorageStrategyRule.destroy(params[:storage_strategy_rule])
    redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
  end

  def replenishment_locations
    @warehouse = User.find(session[:user_id]).warehouse
    if request.post?
      params[:location].delete_if {|k,v| v.blank? }
      params[:location][:warehouse_id] = @warehouse.id
      params[:location][:replenishable] = true
      @locations = Location.all(:conditions => params[:location])
    end
  end

  def product_location_assignments
    @location = Location.find(params[:location])
    @product_location_assignments = @location.product_location_assignments
    @warehouse = @location.warehouse
    @products = @warehouse.products
  end
  
  def create_product_location_assignment
    @product_location_assignment = ProductLocationAssignment.new(params[:product_location_assignment])
    @location = Location.find(params[:product_location_assignment][:location_id])
    if @product_location_assignment.save
      flash[:notice] = "Product Location Assignment created"
    else
      flash[:notice] = "Error creating Product Location Assignment"
    end
    redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @location
  end
  
  def edit_product_location_assignment
    @product_location_assignment = ProductLocationAssignment.find(params[:product_location_assignment])
    @location = @product_location_assignment.location
    @warehouse = @location.warehouse
    
  end
  
  def update_product_location_assignment
    @product_location_assignment = ProductLocationAssignment.find(params[:product_location_assignment][:id])
    if @product_location_assignment.update_attributes(params[:product_location_assignment])
      redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @product_location_assignment.location
    else
      flash[:notice] = "Error updating Product Location Assignment"
      redirect_to :controller => 'admin', :action => 'edit_product_location_assignment', :product_location_assignment => @product_location_assignment 
    end    
  end
  
  def delete_product_location_assignment
    @location = ProductLocationAssignment.find(params[:product_location_assignment]).location
    ProductLocationAssignment.destroy(params[:product_location_assignment])
    redirect_to :controller => 'admin', :action => 'product_location_assignments', :location => @location
  end
  

end 
