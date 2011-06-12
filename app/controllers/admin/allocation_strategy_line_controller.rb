class Admin::AllocationStrategyLineController < ApplicationController
  
  before_filter :authorize
  
  def allocation_strategy_lines
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy])
  end
  
  def create_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.new(params[:allocation_strategy_line])
    if @allocation_strategy_line.save
      flash[:notice] = "Allocation Strategy Line created succesfully"
    else
      flash[:notice] = "Error creating Allocation Strategy Line"
    end
    redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy_line.allocation_strategy
  end
  
  def edit_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.find(params[:allocation_strategy_line])
  end

  def update_allocation_strategy_line
    @allocation_strategy_line = AllocationStrategyLine.find(params[:allocation_strategy_line][:id])
    if @allocation_strategy_line.update_attributes(params[:allocation_strategy_line])
      redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy_line.allocation_strategy
    else
      flash[:notice]  = "Error updating Allocation Strategy Line"
      redirect_to :controller => 'admin', :action => 'edit_allocation_strategy_line', :allocation_strategy_line => @allocation_strategy_line  
    end
  end
  
  def delete_allocation_strategy_line
    @allocation_strategy = AllocationStrategyLine.find(params[:allocation_strategy_line]).allocation_strategy
    AllocationStrategyLine.destroy(params[:allocation_strategy_line])
    redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy
  end
  


end
