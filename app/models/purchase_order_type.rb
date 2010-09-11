class PurchaseOrderType < ActiveRecord::Base
  
  validates	:purchase_order_type, :company_id, :presence => true
  validates	:purchase_order_type, :scope => company_id, :uniqueness => true
  
  has_many	:purchase_orders
  
  def deleteable?
    self.purchase_orders.empty?
  end


end
