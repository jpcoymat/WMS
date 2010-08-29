class SetupController < ApplicationController

	def index
		@countries = Country.find(:all, :order => 'code')
	end

	def create_company
		@company = Company.new(params[:company])
		if @company.save
			@company.create_uoms
			@company.create_assignment_types
			@company.product_statuses
			redirect_to :controller => 'setup', :action => 'defualt_uom_setup', :company => @company
		else
			flash[:notice] = "Error creating company.  Please try again."
			redirect_to :controller => 'setup', :action => 'index'
		end
	end

	def defualt_uom_setup
		@company = Company.find(params[:company])
		@dim_uoms = DimensionUom.find(:all, :conditions => ["company_id = ?", @company.id])
		@qty_uoms = QuantityUom.find(:all, :conditions => ["company_id = ?", @company.id])
		@wgt_uoms = WeightUom.find(:all, :conditions => ["company_id = ?", @company.id])
	end
	

	def update_company_uoms
		@company = Company.find(params[:company][:id])
		if @company.update_attributes(params[:company])
			flash[:notice] = "Company updated correctly."
			redirect_to :controller => 'setup', :action => 'create_warehouses', :company => @company
		else
			flash[:notice] = "Cannot update company.  Please try again."
			redirect_to :controller => 'setup', :action => 'default_uom_setup', :company => @company		
		end
	end

	def create_warehouses
		@company = Company.find(params[:company])
	end
	
	def add_warehouse
    @warehouse = Warehouse.new(params[:warehouse])
	  if @warehouse.save
	    @warehouse.add_system_parameters
	    flash[:notice] = "Warehouse has been succesfully created."
	    redirect_to :controller => 'setup', :action => 'warehouse_users', :warehouse => @warehouse
	  else
      flash[:notice] = "Error creating warehouse"
      redirect_to :controller => 'setup', :action => 'create_warehouses', :company => @warehouse.company
	 end
	end
	
	def warehouse_users
	  @warehouse = Warehouse.find(params[:warehouse])
	end
	
	def add_user
	 @user = User.new(params[:user])
	 if @user.save
	   flash[:notice] = "User Created Succesfully"
   else
     flash[:notice] = "Error creating user"
   end
   redirect_to :controller => 'setup', :action => 'warehouse_users', :warehouse => @user.warehouse 
	end


end
