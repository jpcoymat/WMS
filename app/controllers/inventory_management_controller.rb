class InventoryManagementController < ApplicationController

  def index
  end

  def containers
	@products = Product.all(:order => "name")
	if request.post?
		@order = Order.where(:order_number => params[:container][:order_number]).first unless params[:container][:order_number].nil?
		@receipt = Receipt.where(:receipt_number => params[:container][:receipt_number]).first unless params[:container][:receipt_number].nil?
		@location = Location.where(:name => params[:container][:location_name]).first unless params[:container][:location_name].nil?
		@product = Product.find(params[:container][:product_id]) unless params[:container][:product_id].nil?
		@shipment = Shipment.where(:shipment_number => params[:container][:shipment_number]).first unless params[:container][:shipment_number].nil?		
		lookup_criteria = {}
		lookup_criteria["order"] = @order unless @order.nil?
		lookup_criteria["receipt"] = @receipt unless @receipt.nil?
		lookup_criteria["location"] = @location unless @location.nil?
		lookup_criteria["product"] = @product unless @product.nil?
	end
  end

  def inventory_updates
  end

  def locations
  end

  def shipments
  end

  def assignments
  end

end
