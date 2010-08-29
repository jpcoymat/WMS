class MainController < ApplicationController

  before_filter :authorize

  def index
    @user = User.find_by_id(session[:user_id])
  end


end
