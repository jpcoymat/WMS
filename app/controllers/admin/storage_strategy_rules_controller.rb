class Admin::StorageStrategyRulesController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @company = @warehouse.company
    @storage_strategy_rules = @warehouse.storage_strategy_rules
  end
  
  def create
    @storage_strategy_rule = StorageStrategyRule.new(params[:storage_strategy_rule])
    if @storage_strategy_rule.save
      flash[:notice] = "Storage Strategy Rule created succesfully"
    else
      flash[:notice] = "Error creating Storage Strategy Rule"
    end
    redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
  end

  def edit
    @warehouse = User.find(session[:user_id]).warehouse
    @company = @warehouse.company
    @storage_strategy_rule = StorageStrategyRule.find(params[:storage_strategy_rule])
  end
  
  def update
    @storage_strategy_rule = StorageStrategyRule.find(params[:storage_strategy_rule][:id])
    if @storage_strategy_rule.update_attributes(params[:storage_strategy_rule])
      redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
    else
      flash[:notice] = "Error updating Storage Strategy Rules"
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy_rule', :storage_strategy_rule => @storage_strategy_rule
    end
  end
  
  def delete
    StorageStrategyRule.destroy(params[:storage_strategy_rule])
    redirect_to :controller => 'admin', :action => 'storage_strategy_rules'
  end
  


end
