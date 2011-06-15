class Admin::UomsController < ApplicationController

  before_filter :authorize
  
  def index
    @uoms = Uom.all(:conditions => ["company_id = ?", User.find(session[:user_id]).company.id])
  end

  def create
    @uom = Uom.new(params[:uom])
    if @uom.save
      flash[:notice] = "UOM record saved succesfully"
    else
      flash[:notice] = "Error creating UOM record"
    end
    redirect_to :controller => 'admin', :action => 'uoms'
  end
  
  def edit
    @uom = Uom.find(params[:uom])
  end
  
  def update
    @uom = Uom.find(params[:uom][:id])
    if @uom.update_attributes(params[:uom])
      flash[:notice] = "UOM record updated succesfully"
      redirect_to :controller => 'admin', :action => 'uoms'
    else
      flash[:notice] = "Error updating UOM record"
      redirect_to :controller => 'admin', :action => 'edit_uom', :uom => uom
    end
  end

  def destroy
    Uom.destroy(params[:uom])
    redirect_to :contoller => 'admin', :action => 'uoms'
  end
  


end
