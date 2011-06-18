class Admin::SystemParametersController < ApplicationController

  def lookup
    @user = User.find(session[:user_id])
    if request.post?
      params[:system_parameter].delete_if {|k,v| v.blank? }
      params[:system_parameter][:warehouse_id] = @user.warehouse_id
      @system_parameters = SystemParameter.all(:conditions => params[:system_parameter])
    end
  end

  def edit
    @system_parameter = SystemParameter.find(params[:id])
  end
  
  def update
    @system_parameter = SystemParameter.find(params[:id])
    if @system_parameter.update_attributes(params[:system_parameter])
      flash[:notice] = "System Parameter update successfull"
      redirect_to lookup_admin_system_parameters_path
    else
      
      flash[:notice] = "Oops! Something went wrong.  Please try again. " + params[:system_parameter].to_s
      render :action => 'edit'
    end
  end


end
