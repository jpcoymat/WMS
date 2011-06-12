class Admin::AllocationStrategyRuleController < ApplicationController

  before_filter :authorize

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
