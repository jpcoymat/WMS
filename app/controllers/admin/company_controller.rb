class CompanyController < ApplicationController


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
    if @company.save!
      @company.create_uoms
      @company.create_assignment_types
      redirect_to :controller => 'admin', :action => 'company_uom_setup', :notice =>  "Company #{@company.name} created succesfully."
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
      redirect_to @company
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
