class SetupController < ApplicationController

	before_filter :authenticate_user!, :except => [:index, :create_company, :default_uom_setup, :update_company_uoms, :create_warehouses, :add_warehouses, :warehouse_users, :add_warehouse, :add_user]

	def index
		@countries = Country.all(:order => 'iso_code')
	end

	def create_company
		@company = Company.new(params[:company])
		@company.logo_filename = "foo"
		if @company.save!
			@company.create_uoms
			@company.create_product_statuses
			redirect_to defualt_uom_setup_path, :company => @company
		else
			flash[:notice] = "Error creating company.  Please try again."
			redirect_to :controller => 'setup', :action => 'index'
		end
	end

	def defualt_uom_setup
		@company = Company.find(params[:company])
		@dim_uoms = DimensionUom.all(:conditions => ["company_id = ?", @company.id])
		@qty_uoms = QuantityUom.all(:conditions => ["company_id = ?", @company.id])
		@wgt_uoms = WeightUom.all(:conditions => ["company_id = ?", @company.id])
	end
	

	def update_company_uoms
		@company = Company.find(params[:company][:id])
		if @company.update_attributes(params[:company])
			flash[:notice] = "Company updated correctly."
			redirect_to create_warehouses_path, :company => @company
		else
			flash[:notice] = "Cannot update company.  Please try again."
			redirect_to defualt_uom_setup_path, :company => @company		
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
	    redirect_to warehouse_users_path, :warehouse => @warehouse
	  else
      flash[:notice] = "Error creating warehouse"
      redirect_to create_warehouses_path, :company => @warehouse.company
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
   redirect_to warehouse_users_path, :warehouse => @user.warehouse 
	end


end
