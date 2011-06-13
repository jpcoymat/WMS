class Admin::CustomerTypesController < ApplicationController
  
  before_filter :authorize
  
  def index
    @company = User.find(session[:user_id]).company
    @customer_types = @company.customer_types
  end
  
  def create
    @customer_type = CustomerType.new(params[:customer_type])
    if @customer_type.save
      flash[:notice] = "Customer Type created succesfully!"
    else
      flash[:notice] = "Error creating Customer Type"
    end
    redirect_to :controller => 'admin', :action => 'customer_types'
  end
  
  def edit
    @customer_type = CustomerType.find(params[:customer_type])
  end
  
  def update
    @customer_type = CustomerType.find(params[:customer_type][:id])
    if @customer_type.update_attributes(params[:customer_type])
      redirect_to :controller => 'admin', :action => 'customer_types'
    else
      flash[:notice] = "Error updating customer type"
      redirect_to :controller => 'admin', :action => 'edit_customer_type', :customer_type => @customer_type
    end
  end

  def delete
    CustomerType.destroy(params[:customer_type])
    redirect_to :controller => 'admin', :action => 'customer_types'
  end
  

end
