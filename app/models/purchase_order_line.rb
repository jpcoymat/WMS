class PurchaseOrderLine < ActiveRecord::Base

  validates_presence_of   :line_number, :purchase_order_id, :product_id, :quantity
  validates_uniqueness_of :line_number, :scope => :purchase_order_id
  
  belongs_to              :purchase_order
  belongs_to              :product
  belongs_to              :product_status

end
