class LoginController < ApplicationController

  before_filter :authorize, :except => [:login, :validate_user]

  def login    
  end
  
  def validate_user
    @user = User.where(:username => params[:user_login][:username]).first    
    if @user and @user.authenticate(params[:user_login][:password]) 
      flash[:notice] = "Welcome to WMS."
      session[:user_id] = @user.id
      redirect_to :controller => 'main', :action => 'index'
    else
      flash[:notice] = "Invalid username/password."
      redirect_to :controller => 'login', :action => 'login'
    end    
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => 'login', :action => 'login'
  end

end
