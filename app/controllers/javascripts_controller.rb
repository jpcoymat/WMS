class JavascriptsController < ApplicationController

  def dynamic_product_subcategories
    @product_subcategories = User.find(session[:user_id]).company.product_subcategories
  end


end
