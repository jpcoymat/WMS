class Admin::CompaniesController < ApplicationController



  def index
    @companies = Company.all(:order => 'name')
  end

  def new
    @company = Company.new
    @countries = Country.all(:order => 'name')
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])
    if @company.save!
      @company.create_uoms
      @company.create_product_statuses
      flash[:notice] =  "Company #{@company.name} created succesfully."
      redirect_to uom_setup_admin_company_path(@company)
    else
      @countries = Country.all(:order => 'name')
      render :action => 'new'
    end
  end
  
  def uom_setup
    @company        = Company.find(params[:id])
    @quantity_uoms  = QuantityUom.all(:conditions => "company_id = #{@company.id} ")
    @dimension_uoms = DimensionUom.all(:conditions => "company_id = #{@company.id}")
    @weight_uoms    = WeightUom.all(:conditions => "company_id = #{@company.id} ")
    @volume_uoms    = VolumeUom.all(:conditions => "company_id = #{@company.id} ")    
  end

  def edit
    @company = Company.find(params[:id])
    @countries = Country.all(:order => 'name')
    @quantity_uoms = QuantityUom.all(:conditions => "company_id = #{@company.id} ")
    @weight_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")
    @dimension_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")    
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Company info updated succesfully"
      redirect_to admin_companies_path
    else	
      flash[:notice] = "Error updating company information"
      @countries = Country.all(:order => 'name')
      @quantity_uoms = QuantityUom.all(:conditions => "company_id = #{@company.id} ")
      @weight_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")
      @dimension_uoms = Uom.all(:conditions => "company_id = #{@company.id} ")    
      render :action => 'edit_company'  
    end
  end


end
