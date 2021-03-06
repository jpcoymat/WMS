class Admin::AllocationStrategyLinesController < ApplicationController
  
  before_filter :authorize
  
  def index
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy_id])
    @allocation_strategy_line = AllocationStrategyLine.new
  end
  
  def create
    @allocation_strategy_line = AllocationStrategyLine.new(params[:allocation_strategy_line])
    if @allocation_strategy_line.save
      flash[:notice] = "Allocation Strategy Line created succesfully"
    else
      flash[:notice] = "Error creating Allocation Strategy Line"
    end
    redirect_to admin_allocation_strategy_allocation_strategy_lines_path(@allocation_strategy_line.allocation_strategy_id)
  end
  
  def edit
    @allocation_strategy_line = AllocationStrategyLine.find(params[:id])
    @allocation_strategy = @allocation_strategy_line.allocation_strategy
    
  end

  def update
    @allocation_strategy_line = AllocationStrategyLine.find(params[:id])
    if @allocation_strategy_line.update_attributes(params[:allocation_strategy_line])
      redirect_to admin_allocation_strategy_allocation_strategy_lines_path(@allocation_strategy_line.allocation_strategy_id)
    else
      flash[:notice]  = "Error updating Allocation Strategy Line"
      render :action => 'edit'  
    end
  end
  
  def destroy
    @allocation_strategy = AllocationStrategyLine.find(params[:id]).allocation_strategy
    AllocationStrategyLine.destroy(params[:id])
    redirect_to admin_allocation_strategy_allocation_strategy_lines_path(@allocation_strategy.id)
  end
  


end
