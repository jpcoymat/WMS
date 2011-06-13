class Admin::SystemParametersController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    if request.post?
      params[:system_parameter].delete_if {|k,v| v.blank? }
      params[:system_parameter][:warehouse_id] = @user.warehouse_id
      @system_parameters = SystemParameter.all(:conditions => params[:system_parameter])
    end
  end

  def edit
    @system_parameter = SystemParameter.find(params[:system_parameter])
  end
  
  def update
    @system_parameter = SystemParameter.find(params[:system_parameter][:id])
    if @system_parameter.update_attributes(params[:system_parameter])
      flash[:notice] = "System Parameter update successfull"
      redirect_to :controller => 'admin', :action => 'system_parameters'
    else
      
      flash[:notice] = "Oops! Something went wrong.  Please try again. " + params[:system_parameter].to_s
      redirect_to :controller => 'admin', :action => 'edit_system_parameter', :system_parameter => @system_parameter
    end
  end


end
