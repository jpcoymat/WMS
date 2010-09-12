class AdminController < ApplicationController

  before_filter :authorize

  def companies
    @companies = Company.all(:order => 'name')
  end

  def new_company
    @company = Company.new
    @countries = Country.all(:order => 'name')
  end

  def view_company
    @company = Company.find(params[:company])
  end

  def create_company
    @company = Company.new(params[:company])
    if @company.save
      @company.create_uoms
      @company.create_assignment_types
      flash[:notice] = "Company #{@company.name} created succesfully."
      redirect_to :controller => 'admin', :action => 'company_uom_setup'
    else
      redirect_to :controller => 'admin', :action => 'new_company'
    end
  end
  
  def company_uom_setup
    @company        = Company.find(params[:company])
    @quantity_uoms  = QuantityUom.all(:conditions => "company_id = #{@company.id} ")
    @weight_uoms    = WeightUom.all(:conditions => "company_id = #{@company.id} ")
    @volume_uoms    = VolumeUom.all(:conditions => "company_id = #{@company.id} ")    
  end

  def edit_company
    @company = Company.find(params[:company])
    @countries = Country.all(:order => 'name')
    @quantity_uoms = QuantityUom.all(:conditions => "company_id = #{@company.id} ")
    @weight_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")
    @dimension_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")    
  end

  def update_company
    @company = Company.find(params[:company][:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Company info updated succesfully"
      redirect_to :controller => 'admin', :action => 'view_company', :company => @company
    else	
      flash[:notice] = "Error updating company information"
      redirect_to :controller => 'admin', :action => 'edit_company', :company => @company
    end
  end

  def warehouses
    @company = User.find(session[:user_id]).company 
  end
  
  def view_warehouse
    @warehouse = Warehouse.find(params[:warehouse])
  end
  
  def add_warehouse
    @warehouse = Warehouse.new
  end
  
  def create_warehouse
    @warehouse = Warehouse.new(params[:warehouse])
    if @warehouse.save
      @warehouse.add_system_parameters
      redirect_to :controller => 'admin', :action => 'warehouses'
    else
      flash[:notice] = "Error creating new warehouse.  Please try again."
      redirect_to :controller => 'admin', :action => 'warehouses'
    end
  end
  
  def edit_warehouse
    @warehouse = Warehouse.find(params[:warehouse])    
  end
  
  def update_warehouse
    @warehouse = Warehouse.find(params[:warehouse][:id])
    if @warehouse.update_attributes(params[:warehouse])
      redirect_to :controller => 'admin', :action => 'view_warehouse', :warehouse => @warehouse
    else
      flash[:notice] = "Error updating warehouse.  Please try again."
      redirect_to :controller =>'admin', :action => 'edit_warehouse', :warehouse => @warehouse
    end
  end
  
  def delete_warehouse
    Warehouse.destroy(params[:warehouse])
    redirect_to :controller => 'admin', :action => 'warehouses'
  end
  
  def dock_doors
    @warehouse = Warehouse.find(params[:warehouse])
    @dock_doors = @warehouse.dock_doors    
  end
  
  def create_dock_door
    @warehouse = Warehouse.find(params[:dock_door][:warehouse_id])
    @dock_door = DockDoor.new(params[:dock_door])
    if @dock_door.save
      flash[:notice] = "Dock Door created succesfully"
    else
      flash[:notice] = "Error creating Dock Door"
    end
    redirect_to :controller => 'admin', :action => 'dock_doors', :warehouse => @warehouse
  end

  def edit_dock_door
    @dock_door = DockDoor.find(params[:dock_door])
  end
  
  def update_dock_door
    @dock_door = DockDoor.find(params[:dock_door][:id])
    if @dock_door.update_attributes(params[:dock_door])
      redirect_to :controller => 'admin', :action => 'dock_doors', :warehouse => @dock_door.warehouse
    else
      flash[:notice] = "Error updating Dock Door"
      redirect_to :controller => 'admin', :action => 'edit_dock_door', :dock_door => @dock_door
    end
  end

  def system_parameters
    @user = User.find(session[:user_id])
    if request.post?
      params[:system_parameter].delete_if {|k,v| v.blank? }
      params[:system_parameter][:warehouse_id] = @user.warehouse_id
      @system_parameters = SystemParameter.all(:conditions => params[:system_parameter])
    end
  end

  def edit_system_parameter
    @system_parameter = SystemParameter.find(params[:system_parameter])
  end
  
  def update_system_parameter
    @system_parameter = SystemParameter.find(params[:system_parameter][:id])
    if @system_parameter.update_attributes(params[:system_parameter])
      flash[:notice] = "System Parameter update successfull"
      redirect_to :controller => 'admin', :action => 'system_parameters'
    else
      
      flash[:notice] = "Oops! Something went wrong.  Please try again. " + params[:system_parameter].to_s
      redirect_to :controller => 'admin', :action => 'edit_system_parameter', :system_parameter => @system_parameter
    end
  end
  
  def product_categories
    @product_categories = ProductCategory.all(:order => "name", :conditions => ["company_id = ?", User.find(session[:user_id]).warehouse.company_id])
  end
  
  def create_product_category
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      flash[:notice] = "New Product Category created succesfully"
    else   
      flash[:notice] = "Error Creating Product Category"
    end
    redirect_to :controller => 'admin', :action => 'product_categories'
  end
  
  def edit_product_category
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def update_product_category
    @product_category = ProductCategory.find(params[:product_category][:id])
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Product Category updated correctly"
      redirect_to :controller => 'admin', :action => 'product_categories'
    else
      flash[:notice] = "Error updating Product Category"
      redirect_to :controller => 'admin', :action => 'edit_product_category', :product_category => @product_category     
    end
  end
  
  def delete_product_category
    @product_category = ProductCategory.find(params[:product_category])
    @product_category.destroy
    flash[:notice] = "Product Category has been deleted"
    redirect_to :controller => 'admin', :action => 'product_categories'
  end
  
  def product_subcategories
    @product_category = ProductCategory.find(params[:product_category])
    @product_subcategories = @product_category.product_subcategories
  end
  
  def create_product_subcategory
    @product_category = ProductCategory.find(params[:product_subcategory][:product_category_id])
    @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
    if @product_subcategory.save
      flash[:notice] = "Product Subcategory created succesfully"
    else
      flash[:notice] = "Error creating Product Subcategory"
    end
    redirect_to :controller => 'admin', :action => 'product_subcategories', :product_category => @product_category
  end
  
  def edit_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory])
  end
  
  def update_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory][:id])
    if @product_subcategory.update_attributes(params[:product_subcategory])
      flash[:notice] = "Product Subcategory updated correctly"
      redirect_to :controller => 'admin', :action => 'product_subcategories', :product_category => @product_subcategory.product_category
    else
      flash[:notice] = "Error updating Product Subcategory"
      redirect_to :controller => 'admin', :action => 'edit_product_subcategory', :product_subcategory => @product_subcategory     
    end
  end
  
  def delete_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory])
    @product_category = @product_subcategory.product_category
    @product_subcategory.destroy
    flash[:notice] = "Product Subcategory deleted"
    redirect_to :controller => 'admin', :action => 'product_subcategories', :product_category => @product_category    
  end
  
  def products
    @warehouse = User.find(session[:user_id]).warehouse
    @company =  @warehouse.company
    if request.post?
      
      params[:product].delete_if {|k,v| v.blank?  }
      params[:product][:company_id]  = @company.id  
      @products = Product.all(:conditions => params[:product])
      
    end
  end
  
  def view_product
    @product = Product.find(params[:product])
  end

  def edit_product
    @product = Product.find(params[:product])
  end
  
  def update_product
    @product = Product.find(params[:product][:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product updated succesfully"
      redirect_to :controller => 'admin', :action => 'view_product', :product => @product
    else
      flash[:notice] = "Error updating product"
      redirect_to :controller => 'admin', :action => 'edit_product', :product => @product
    end
  end
  
  def add_product
    @product = Product.new
  end
  
  def create_product
    @product = Product.new(params[:product])
    if @product.save
      redirect_to :controller => 'admin', :action => 'product_packages', :product => @product
    else
      redirect_to :controller => 'admin', :action => 'add_product'
    end
  end
  
  def product_packages
    @product = Product.find(params[:product])
  end
  
  def create_product_package
    @product = Product.find(params[:product_package][:product_id])
    @product_package = ProductPackage.new(params[:product_package])
    if @product_package.save
      flash[:notice] = "Product Package record created succesfully"
    else
      flash[:notice] = "Error creating Product Package record"
    end
    redirect_to :controller => 'admin', :action => 'product_packages', :product => @product
  end

  def edit_product_package
    @product_package = ProductPackage.find(params[:product_package])
  end
  
  def update_product_package
    @product_package = ProductPackage.find(params[:product_package][:id])
    if @product_package.update_attributes(params[:product_package])
      flash[:notice] = "Prouct Package record updated succesfully"
      redirect_to :controller => 'admin', :action => 'product_packages', :product => @product_package.product
    else
      flash[:notice] = "Error updating Product Package"
      redirect_to :controller => 'admin', :action => 'edit_product_package', :product_package => @product_package
    end
  end
  
  def product_warehouse_setup
    @product = Product.find(params[:product])
  end
  
  def create_product_warehouse_setup
    @product = Product.find(params[:product_warehouse_setup][:product_id])
    @product_warehouse_setup = ProductWarehouseSetup.new(params[:product_warehouse_setup])
    if @product_warehouse_setup.save
      flash[:notice] = "Product Warehouse Setup saved"
    else
      flash[:notice] = "Error creating Product Warehouse Setup"
    end
    redirect_to :controller => 'admin', :action => 'product_warehouse_setup', :product => @product
  end
  
  def edit_product_warehouse_setup
    @product_warehouse_setup = ProductWarehouseSetup.find(params[:product_warehouse_setup])
  end
  
  def update_product_warehouse_setup
    @product_warehouse_setup = ProductWarehouseSetup.find(params[:product_warehouse_setup][:id])
    if @product_warehouse_setup.update_attributes(params[:product_warehouse_setup])
      redirect_to :controller => 'admin', :action => 'product_warehouse_setup', :product => @product_warehouse_setup.product
    else
      flash[:notice] = "Error updating Product Warehouse Setup"
      redirect_to :controller => 'admin', :action => 'edit_product_warehouse_setup', :product_warehouse_setup => @product_warehouse_setup
    end
  end
  
  def delete_product_warehouse_setup
    @product = Product.find(params[:product_warehouse_setup][:product_id])
    ProductWarehouseSetup.destroy(params[:product_warehouse_setup])
    redirect_to :controller => 'admin', :action => 'product_warehouse_setup', :product => @product
  end
  
  def uoms
    @uoms = Uom.all(:conditions => ["company_id = ?", User.find(session[:user_id]).company.id])
  end

  def create_uom
    @uom = Uom.new(params[:uom])
    if @uom.save
      flash[:notice] = "UOM record saved succesfully"
    else
      flash[:notice] = "Error creating UOM record"
    end
    redirect_to :controller => 'admin', :action => 'uoms'
  end
  
  def edit_uom
    @uom = Uom.find(params[:uom])
  end
  
  def update_uom
    @uom = Uom.find(params[:uom][:id])
    if @uom.update_attributes(params[:uom])
      flash[:notice] = "UOM record updated succesfully"
      redirect_to :controller => 'admin', :action => 'uoms'
    else
      flash[:notice] = "Error updating UOM record"
      redirect_to :controller => 'admin', :action => 'edit_uom', :uom => uom
    end
  end

  def delete_uom
    Uom.destroy(params[:uom])
    redirect_to :contoller => 'admin', :action => 'uoms'
  end
  
  def suppliers
    @suppliers = Supplier.all(:conditions => ["company_id = ?", User.find(session[:user_id]).company.id])
  end
  
  def create_supplier
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:notice] = "New supplier created"
    else
      flash[:notice] = "Error creating supplier"
    end
    redirect_to :controller => 'admin', :action => 'suppliers'
  end
  
  def edit_supplier
    @supplier = Supplier.find(params[:supplier])
  end
  
  def update_supplier
    @supplier = Supplier.find(params[:supplier][:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "Supplier updated succesfully"
      redirect_to :controller => 'admin', :action => 'suppliers'
    else
      flash[:notice] = "An error occurred updating suppliers"
      redirect_to :controller => 'admin', :action => 'edit_supplier', :supplier => @supplier
    end
  end
  
  def delete_supplier
    Supplier.destroy(params[:supplier])
    redirect_to :controller => 'admin', :action => 'suppliers'
  end
  
  def receipt_types
    @company = User.find(session[:user_id]).company
    @receipt_types = @company.receipt_types
  end
  
  def create_receipt_type
    @receipt_type = ReceiptType.new(params[:receipt_type])
    if @receipt_type.save
      flash[:notice] = "Receipt Type created succesfully"
    else
      flash[:notice] = "Error creating Receipt Type"
    end
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  
  def edit_receipt_type 
    @receipt_type = ReceiptType.find(params[:receipt_type])
  end
  
  def update_receipt_type
    @receipt_type = ReceiptType.find(params[:receipt_type][:id])
    if @receipt_type.update_attributes(params[:receipt_type])
      redirect_to :controller => 'admin', :action => 'receipt_types'
    else
      flash[:notice] = "Error updating Receipt Type"
      redirect_to :controller => 'admin', :action => 'edit_receipt_type', :receipt_type => @receipt_type
    end
  end  
  
  def delete_receipt_type
    ReceiptType.destroy(params[:receipt_type])
    redirect_to :controller => 'admin', :action => 'receipt_types'
  end
  
  def product_statuses
    @company = User.find(session[:user_id]).company
    @product_statuses = ProductStatus.all
  end
  
  def create_product_status
    @product_status = ProductStatus.new(params[:product_status])
    if @product_status.save
      flash[:notice] = "Product Status created succesfully"
    else
      flash[:notice] = "Error creating product status"
    end
    redirect_to :controller => 'admin', :action => 'product_statuses'
  end
  
  def edit_product_status
    @product_status = ProductStatus.find(params[:product_status])
  end
  
  def update_product_status
    @product_status = ProductStatus.find(params[:product_status][:id])
    if @product_status.update_attributes(params[:product_status])
      flash[:notice] = "Product Status updated correctly"
    else
      flash[:notice] = "Error updating Product Status"
    end
    redirect_to :controller => 'admin', :action => 'product_statuses'
  end
  
  def storage_zones
    @storage_zones = StorageZone.all(:conditions => ["warehouse_id = ?", User.find(session[:user_id]).warehouse.id])
  end
  
  def edit_storage_zone
    @storage_zone = StorageZone.find(params[:storage_zone])
  end
  
  def update_storage_zone
    @storage_zone = StorageZone.find(params[:storage_zone][:id])
    if @storage_zone.update_attributes(params[:storage_zone])
      flash[:notice] = "Storage Zone updated correctly"
      redirect_to :controller => 'admin', :action => 'storage_zones'
    else
      flash[:notice] = "Error updating Storage Zone"
      redirect_to :controller => 'admin', :action => 'edit_storage_zone', :storage_zone => @strorage_zone
    end
  end
  
  def create_storage_zone
    @storage_zone = StorageZone.new(params[:storage_zone])
    if @storage_zone.save
      flash[:notice] = "New Storage Zone created succesfully"
    else
      flash[:notice] = "Error creating new Storage Zone"
    end
    redirect_to :controller => 'admin', :action => 'storage_zones'
  end
  
  def delete_storage_zone
    StorageZone.destroy(params[:storage_zone])
    redirect_to :controlle => 'admin', :action => 'storage_zones'
  end
  
  def location_types
    @location_types = LocationType.all(:order => "code")
  end
  
  def create_location_type
    @location_type = LocationType.new(params[:location_type])
    unless @location_type.save
      flash[:notice] = "Error creating Location Type"
    end
    redirect_to :controller => 'admin', :action => 'location_types'
  end
  
  def view_location_type
    @location_type = LocationType.find(params[:location_type])
  end
  
  def edit_location_type
    @location_type = LocationType.find(params[:location_type])
  end
  
  def update_location_type
    @location_type = LocationType.find(params[:location_type][:id])
    if @location_type.update_attributes(params[:location_type])
      redirect_to :controller => 'admin', :action => 'location_types'
    else
      flash[:notice] = "Error updating location type"
      redirect_to :controller => 'admin', :action => 'edit_location_type', :location_type => @location_type
    end
  end
  
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
      flash[:notice] = "User updated succesfully"
      redirect_to :controller => 'admin', :action => 'users'
    else
      flash[:notice] = "Error updating user profile"
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
      flash[:notice] = "Error creating Storage Strategy"
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
