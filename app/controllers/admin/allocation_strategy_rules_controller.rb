class Admin::AllocationStrategyRulesController < ApplicationController


  def index
    @warehouse = current_user.warehouse
    @allocation_strategy_rules = @warehouse.allocation_strategy_rules
    @allocation_strategy_rule = AllocationStrategyRule.new
  end


  def edit
    @warehouse = User.find(session[:user_id]).warehouse
    @allocation_strategy_rule = AllocationStrategyRule.find(params[:id])
  end
  
  def update
    @allocation_strategy_rule = AllocationStrategyRule.find(params[:id])
    if @allocation_strategy_rule.update_attributes(params[:allocation_strategy_rule])
      redirect_to admin_allocation_strategy_rules_path
    else
      flash[:notice] = "Error updating Allocation Strategy"
      @warehouse = User.find(session[:user_id]).warehouse
      render :action => 'edit' 
    end
  end
  
  def destroy
    AllocationStrategyRule.destroy(params[:id])
    redirect_to admin_allocation_strategy_rules_path
  end
  
  def create
    @allocation_strategy_rule = AllocationStrategyRule.new(params[:allocation_strategy_rule])
    if @allocation_strategy_rule.save
      flash[:notice] = "Allocation Strategy Rule created succesfully"
    else
      flash[:notice] = "Error creating Allocation Strategy Rule"
    end
    redirect_to admin_allocation_strategy_rules_path
  end


end
