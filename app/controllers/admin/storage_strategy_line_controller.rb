class Admin::StorageStrategyLineController < ApplicationController

  before_filter :authorize
  
  def storage_strategy_lines
    @storage_strategy = StorageStrategy.find(params[:storage_strategy])
    @warehouse = @storage_strategy.warehouse
  end
  
  def create_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.new(params[:storage_strategy_line])
    @storage_strategy = StorageStrategy.find(params[:storage_strategy_line][:storage_strategy_id])
    if @storage_strategy_line.save
      flash[:notice] = "Storage Strategy Line added succesfully"
    else
      flash[:notice] = "Error adding Storage Strategy Line"
    end
    redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy
  end

  def edit_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.find(params[:storage_strategy_line])
    @warehouse = @storage_strategy_line.storage_strategy.warehouse
  end
  
  def update_storage_strategy_line
    @storage_strategy_line = StorageStrategyLine.find(params[:storage_strategy_line][:id])
    if @storage_strategy_line.update_attributes(params[:storage_strategy_line])
      redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy_line.storage_strategy
    else
      flash[:notice] = "Error updating Storage Strategy Line"
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy_line', :storage_strategy_line => @storage_strategy_line
    end
  end
  
  def delete_storage_strategy_line
    @storage_strategy = StorageStrategyLine.find(params[:storage_strategy_line]).storage_strategy
    StorageStrategyLine.destroy(params[:storage_strategy_line])
    redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy 
  end
  

end
