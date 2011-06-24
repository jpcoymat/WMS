class JavascriptsController < ApplicationController

  def dynamic_product_subcategories
    @product_subcategories = User.find(session[:user_id]).company.product_subcategories
  end
  
  def dynamic_po_lines
    @purchase_orders = User.find(session[:user_id]).company.purchase_orders
  end

  def set_product
    @products = User.find(session[:user_id]).company.products
    @purchase_order_lines = PurchaseOrderLine.all
  end

end
