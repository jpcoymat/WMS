class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    render :nothing => true, :status => :ok
  end
end
