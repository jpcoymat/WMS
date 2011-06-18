class Admin::StorageStrategiesController < ApplicationController

  before_filter :authorize

  def index
    @warehouse = User.find(session[:user_id]).warehouse
    @storage_strategies = @warehouse.storage_strategies
    @storage_strategy = StorageStrategy.new
  end
  
  def create
    @storage_strategy = StorageStrategy.new(params[:storage_strategy])
    if @storage_strategy.save
      redirect_to admin_storage_strategy_storage_strategy_lines_path(@storage_strategy)
    else
      flash[:notice] = "Error creating Storage Strategy. \n" 
      @storage_strategy.errors.each_full {|msg| flash[:notice] += msg + "\n"}  
      redirect_to admin_storage_strategies_path
    end
  end

  def edit
    @storage_strategy = StorageStrategy.find(params[:id])
  end
  
  def update
    @storage_strategy = StorageStrategy.find(params[:id])
    if @storage_strategy.update_attributes(params[:storage_strategy])
      redirect_to admin_storage_strategies_path
    else
      flash[:notice] = "Oops.  Something went wrong.  Please try again."
      redirect_to edit_admin_storage_strategy_path(@storage_strategy)
    end
  end
  
  def destroy
    @storage_strategy = StorageStrategy.find(params[:id])
    @storage_strategy.destroy
    redirect_to admin_storage_strategies_path
  end
  


end
