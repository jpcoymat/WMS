class Admin::UomsController < ApplicationController
  
  def index
    @user = current_user
    @uoms = @user.warehouse.company.uoms
    @uom = Uom.new
  end

  def create
    @uom = Uom.new(params[:uom])
    @uom.type = params[:uom][:type]
    if @uom.save
      flash[:notice] = "UOM record saved succesfully"
    else
      flash[:notice] = "Error creating UOM record"
      @uom.errors.full_messages.each do |msg|
        flash[:notice] += msg + "\n"
      end
    end
    redirect_to admin_uoms_path
  end
  
  def edit
    @uom = Uom.find(params[:id])
    @uom.becomes(Uom)
  end
  
  def update
    @uom = Uom.find(params[:id])
    if @uom.update_attributes(params[:uom])
      flash[:notice] = "UOM record updated succesfully " 
      redirect_to admin_uoms_path
    else
      flash[:notice] = "Error updating UOM record"
      render :action => 'edit'
    end
  end

  def destroy
    Uom.destroy(params[:id])
    redirect_to admin_uoms_path
  end
  


end
