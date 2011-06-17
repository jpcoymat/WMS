class Admin::AllocationStrategiesController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @allocation_strategies = @warehouse.allocation_strategies
    @allocation_strategy = AllocationStrategy.new
  end
  
  def create
    @allocation_strategy = AllocationStrategy.new(params[:allocation_strategy])
    if @allocation_strategy.save
      redirect_to admin_allocation_strategy_allocation_strategy_lines_path(@allocation_strategy.id)
    else
      flash[:notice] = "Error creating allocation strategy"
      redirect_to admin_allocation_strategies_path
    end
  end
  
  def edit
    @allocation_strategy = AllocationStrategy.find(params[:id])
  end
  
  def update
    @allocation_strategy = AllocationStrategy.find(params[:id])
    if @allocation_strategy.update_attributes(params[:allocation_strategy])
      redirect_to admin_allocation_strategies_path
    else
      flash[:notice] = "Error updating Allocation Strategy"
      render :action => 'edit'  
    end
  end
  
  def destroy
    AllocationStrategy.destroy(params[:id])
    redirect_to admin_allocation_strategies_path
  end
  

end
