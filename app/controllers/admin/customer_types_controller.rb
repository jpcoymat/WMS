class Admin::CustomerTypesController < ApplicationController
  

  
  def index
    @company = current_user.company
    @customer_types = @company.customer_types
    @customer_type = CustomerType.new
  end
  
  def create
    @customer_type = CustomerType.new(params[:customer_type])
    if @customer_type.save
      flash[:notice] = "Customer Type created succesfully!"
    else
      flash[:notice] = "Error creating Customer Type"
    end
    redirect_to admin_customer_types_path
  end
  
  def edit
    @customer_type = CustomerType.find(params[:id])
  end
  
  def update
    @customer_type = CustomerType.find(params[:id])
    if @customer_type.update_attributes(params[:customer_type])
      redirect_to admin_customer_types_path
    else
      flash[:notice] = "Error updating customer type"
      render :action => 'edit'
    end
  end

  def destroy
    CustomerType.destroy(params[:id])
    redirect_to admin_customer_types_path
  end
  

end
