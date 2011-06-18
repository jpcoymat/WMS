class Admin::UsersController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse 
    @users = @warehouse.users
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New user created succesfully"
    else
      flash[:notice] = "Error creating new user"
    end
    redirect_to admin_users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :action => 'edit'
    end    
  end
  

end
