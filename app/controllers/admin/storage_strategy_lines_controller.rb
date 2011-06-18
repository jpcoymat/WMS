class Admin::StorageStrategyLinesController < ApplicationController

  before_filter :authorize
  
  def index
    @storage_strategy = StorageStrategy.find(params[:storage_strategy_id])
    @warehouse = @storage_strategy.warehouse
    @storage_strategy_line = StorageStrategyLine.new
  end
  
  def create
    @storage_strategy_line = StorageStrategyLine.new(params[:storage_strategy_line])
    @storage_strategy = StorageStrategy.find(params[:storage_strategy_line][:storage_strategy_id])
    if @storage_strategy_line.save
      flash[:notice] = "Storage Strategy Line added succesfully"
    else
      flash[:notice] = "Error adding Storage Strategy Line"
    end
    redirect_to admin_storage_strategy_storage_strategy_lines_path(@storage_strategy)
  end

  def edit
    @storage_strategy_line = StorageStrategyLine.find(params[:id])
    @warehouse = @storage_strategy_line.storage_strategy.warehouse
    @storage_strategy = @storage_strategy_line.storage_strategy
  end
  
  def update
    @storage_strategy_line = StorageStrategyLine.find(params[:id])
    if @storage_strategy_line.update_attributes(params[:storage_strategy_line])
      redirect_to admin_storage_strategy_storage_strategy_lines_path(@storage_strategy_line.storage_strategy)
    else
      flash[:notice] = "Error updating Storage Strategy Line"
      @storage_strategy = @storage_strategy_line.storage_strategy
      render :action => 'edit'
    end
  end
  
  def destroy
    @storage_strategy_line = StorageStrategyLine.find(params[:id])
    @storage_strategy = @storage_strategy_line.storage_strategy
    @storage_strategy_line.destroy
    redirect_to admin_storage_strategy_storage_strategy_lines_path(@storage_strategy)
  end
  

end
