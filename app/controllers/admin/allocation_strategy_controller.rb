class AllocationStrategyController < ApplicationController

  before_filter :authorize
  
  def allocation_strategies
    @warehouse = User.find(session[:user_id]).warehouse
    @allocation_strategies = @warehouse.allocation_strategies
  end
  
  def create_allocation_strategy
    @allocation_strategy = AllocationStrategy.new(params[:allocation_strategy])
    if @allocation_strategy.save
      redirect_to :controller => 'admin', :action => 'allocation_strategy_lines', :allocation_strategy => @allocation_strategy
    else
      flash[:notice] = "Error creating allocation strategy"
      redirect_to :controller => 'admin', :action => 'allocation_strategy'
    end
  end
  
  def edit_allocation_strategy
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy])
  end
  
  def update_allocation_strategy
    @allocation_strategy = AllocationStrategy.find(params[:allocation_strategy][:id])
    if @allocation_strategy.update_attributes(params[:allocation_strategy])
      redirect_to :controller => 'admin', :action => 'allocation_strategies'
    else
      flash[:notice] = "Error updating Allocation Strategy"
      redirect_to :controller => 'admin', :action => 'edit_allocation_strategy', :allocation_strategy => @allocation_strategy  
    end
  end
  
  def delete_allocation_strategy
    AllocationStrategy.destroy(params[:allocation_strategy])
    redirect_to :controller => 'admin', :action => 'allocation_strategies'
  end
  

end
