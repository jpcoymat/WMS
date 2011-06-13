class Admin::UsersController < ApplicationController

  before_filter :authorize
  
  def index
    @warehouse = User.find(session[:user_id]).warehouse 
    @users = @warehouse.users
  end
  
  def show
    @user = User.find(params[:user])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New user created succesfully"
    else
      flash[:notice] = "Error creating new user"
    end
    redirect_to :controller => 'admin', :action => 'users'
  end
  
  def edit
    @user = User.find(params[:user])
  end
  
  def update
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
      redirect_to :controller => 'admin', :action => 'users'
    else
      redirect_to :controller => 'admin', :action => 'edit_user', :user => @user
    end    
  end
  

end
