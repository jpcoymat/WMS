# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  
  def authorize 
    unless User.find(session[:user_id])
      flash[:notice] = "Please log in"
      redirect_to :controller => "login", :action=>"login"
    end
  end  
  
  
end
