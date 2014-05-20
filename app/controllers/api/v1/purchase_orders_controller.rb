class Api::V1::PurchaseOrdersController < ApplicationController
  respond_to :json

  def search
    po = PurchaseOrder.find_by_purchase_order_number(params[:po_number])
    respond_with(po, status: po.blank? ? 404 : 200)
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
    purchase_orders = PurchaseOrder.where("state in ('created', 'in_receiving')")
    respond_with(purchase_orders, status: 200)
  end

  def receive_container
    @container = Container.new(params[:container])
    @container.location = current_user
    @container.lp  = @container.id
    if @container.save
      respond_with(@container, status: 200)
    else
      respond_with(@container, status: 422)
    end
  end
  
  def containers
    @purchase_order = PurchaseOrder.find(params[:id])
    @containers = @purchase_order.containers
    respond_to do |format|
      format.json do
        render :json => @containers.to_json({:include => {:container_contents => {:include => :product}}}), status: 200
      end
    end
  end
  
  
end
