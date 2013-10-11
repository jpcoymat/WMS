class LoginController < ApplicationController
  before_filter :authenticate_user!, :except => [:login]
  protect_from_forgery :except => :login
  
  def login    
    if request.post?
      if authenticate_user!
        flash[:notice] = "Welcome to WMS."
        redirect_to :controller => 'main', :action => 'index' 
      else
        flash[:notice] = "Invalid username/password."
        redirect_to :controller => 'login', :action => 'login'
      end
    end
  end

  def logout
    sign_out current_user
    redirect_to :controller => 'login', :action => 'login'
  end

end
