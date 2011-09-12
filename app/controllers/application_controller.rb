class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  protected

  def authorize
    unless session[:user_id] and User.find(session[:user_id])
      redirect_to :controller => 'login', :action => 'login'
    end
  end

end
