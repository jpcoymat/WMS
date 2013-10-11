class Admin::StorageStrategyRulesController < ApplicationController


  def index
    @warehouse = current_user.warehouse
    @company = @warehouse.company
    @storage_strategy_rules = @warehouse.storage_strategy_rules
    @storage_strategy_rule = StorageStrategyRule.new
  end
  
  def create
    @storage_strategy_rule = StorageStrategyRule.new(params[:storage_strategy_rule])
    if @storage_strategy_rule.save
      flash[:notice] = "Storage Strategy Rule created succesfully"
    else
      flash[:notice] = "Error creating Storage Strategy Rule"
    end
    redirect_to admin_storage_strategy_rules_path 
  end

  def edit
    @warehouse = current_user.warehouse
    @company = @warehouse.company
    @storage_strategy_rule = StorageStrategyRule.find(params[:id])
  end
  
  def update
    @storage_strategy_rule = StorageStrategyRule.find(params[:id])
    if @storage_strategy_rule.update_attributes(params[:storage_strategy_rule])
      redirect_to admin_storage_strategy_rules_path
    else
      flash[:notice] = "Error updating Storage Strategy Rules"
      @warehouse = current_user.warehouse
      @company = @warehouse.company
      render :action => 'edit'
    end
  end
  
  def destroy
    StorageStrategyRule.destroy(params[:id])
    redirect_to admin_storage_strategy_rules_path
  end
  


end
