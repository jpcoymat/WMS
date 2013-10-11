class JavascriptsController < ApplicationController

  def dynamic_product_subcategories
    @product_subcategories = current_user.company.product_subcategories
  end
  
  def dynamic_po_lines
    @purchase_orders = current_user.company.purchase_orders
  end

  def set_product
    @products = current_user.company.products
    @purchase_order_lines = PurchaseOrderLine.all
  end

end
