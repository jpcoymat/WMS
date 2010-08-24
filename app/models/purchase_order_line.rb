class PurchaseOrderLine < ActiveRecord::Base

  validates_presence_of   :line_number, :purchase_order_id, :product_id, :quantity
  validates_uniqueness_of :line_number, :scope => :purchase_order_id
  
  belongs_to              :purchase_order
  belongs_to              :product
  belongs_to              :product_status

  has_many                :receipt_lines, :as => :purchase_order_objects


  def editable?
    self.receipt_lines.empty?
  end

  
end
