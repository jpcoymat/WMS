class Api::V1::PurchaseOrdersController < ApplicationController
  respond_to :json

  def search
    po = PurchaseOrder.find_by_purchase_order_number(params[:po_number])
    respond_with(po, :status => po.blank? ? 404 : 200)
  end
  
  def search_by_supplier
    supplier = Supplier.where(name: params[:supplier_name]).first
    if supplier
      respond_with(supplier.purchase_orders.all)
    else
      respond_with(supplier, status: 404)
    end
  end
  
  def index
    respond_with(PurchaseOrder.all, status: 200)
  end

  
  
  
end
