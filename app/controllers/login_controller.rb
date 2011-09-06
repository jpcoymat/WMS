class LoginController < ApplicationController

  before_filter :authorize, :except => [:login]

  def login
    if request.post?
      @user = User.where(:username => params[:user_login][:username])    
      if @user.authenticate(params[:user_login][:password]) 
        flash[:notice] = "Welcome to WMS."
        session[:user_id] = @user.id
        redirect_to :controller => 'main', :action => 'index'
      else
        flash[:notice] = "Invalid username/password."
        redirect_to :controller => 'login', :action => 'login'
      end
    end
    
  end

  def logout
  end

end
