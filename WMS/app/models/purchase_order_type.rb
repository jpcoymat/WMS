class PurchaseOrderType < ActiveRecord::Base
  
  validates_presence_of     :purchase_order_type
  validates_uniqueness_of   :purchase_order_type
  
  has_many                  :purchase_orders
  
  def deleteable?
    self.purchase_orders.empty?
  end


end
